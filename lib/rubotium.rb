require 'rubotium/version'
require 'rubotium/jar_reader'
require 'rubotium/adb'
require 'rubotium/apk'
require 'rubotium/cmd'
require 'rubotium/device'
require 'rubotium/devices'
require 'rubotium/formatters/junit_formatter'
require 'rubotium/grouper'
require 'rubotium/test_case'
require 'rubotium/test_suite'
require 'rubotium/runable_test'
require 'rubotium/package'

require 'parallel'
module Rubotium
  class Error < StandardError; end

  class NoDevicesError < Error; end

  class NoMatchedDevicesError < Error; end

  class NoTestSuiteError < Error; end

  class << self
    def new(opts = {})
      raise RuntimeError, "Empty configuration" if opts.empty?
      startTime = Time.now
      application_package = Rubotium::Package.new(opts[:app_apk_path])
      tests_package       = Rubotium::Package.new(opts[:tests_apk_path])
      test_runner         = opts[:runner]

      if (opts[:tests_jar_path])
        test_suites  = JarReader.new(opts[:tests_jar_path]).get_tests
      else
        path_to_jar = File.join(Dir.mktmpdir, 'tests.jar')
        begin
          puts("Convertig dex to jar")
          Rubotium::Apk::Converter.new(tests_package.path, path_to_jar).convert_to_jar
          puts("Reading jar content")
          test_suites = jar_reader  = JarReader.new(path_to_jar).get_tests
        ensure
          FileUtils.remove_entry(path_to_jar)
        end
      end

      tests_count = 0
      test_suites.each{|test_suite|
        tests_count = tests_count + test_suite.test_cases.count
      }

      puts "There are #{test_suites.count} packages with tests in the Jar file"
      puts "#{tests_count} tests to run"

      devices = Devices.new(opts[:device_matcher]).all
      test_suites = Grouper.new(test_suites, devices.count).create_groups

      devices.each_with_index{|device, index|
        device.test_package_name = tests_package.name
        device.test_runner_name  = test_runner || "android.test.InstrumentationTestRunner"
        device.testsuite         = test_suites[index]
      }

      devices = Parallel.map(devices, :in_processes=> devices.count) {|device|
        device.uninstall application_package.name
        device.install application_package.path
        device.uninstall tests_package.name
        device.install tests_package.path
        device.run_tests
        device
      }

      puts "Tests took: #{Time.at(Time.now-startTime).utc.strftime("%H:%M:%S")}"
      devices.each{|device|
        Formatters::JunitFormatter.new(device, opts[:report])
      }
    end
  end
end
