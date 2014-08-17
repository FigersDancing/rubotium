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

      dir = Dir.mktmpdir
      begin
        # use the directory...
        Rubotium::Apk::Converter.new(tests_package.path, File.join(dir, 'tests.jar')).convert_to_jar
        jar_reader  = JarReader.new(opts[:tests_jar_path])
        test_suites = jar_reader.get_tests
      ensure
        # remove the directory.
        FileUtils.remove_entry dir
      end


      # jar_reader  = JarReader.new(opts[:tests_jar_path])
      # test_suites = #jar_reader.get_tests

      tests_count = 0
      test_suites.each{|test_suite|
        tests_count = tests_count + test_suite.test_cases.count
      }

      puts "There are #{test_suites.count} packages with tests in the Jar file"
      puts "#{tests_count} tests to run"

      devices = Devices.new(opts[:device_matcher]).all
      test_suites = Grouper.new(test_suites, devices.count).create_groups

      devices.each{|device|
        device.uninstall application_package.name
        device.install application_package.path
      } if application_package.valid?

      devices.each{|device|
        device.uninstall tests_package.name
        device.install tests_package.path
      } if tests_package.valid?

      devices.each_with_index{|device, index|
        device.test_package_name = tests_package.name
        device.test_runner_name  = "com.soundcloud.android.tests.RandomizingRunner"
        device.testsuite         = test_suites[index]
      }

      devices = Parallel.map(devices, :in_processes=> devices.count) {|device|
        device.run_tests
        device
      }

      puts "Tests took: #{Time.at(Time.now-startTime).utc.strftime("%H:%M:%S")}"
      devices.each{|device|
        Formatters::JunitFormatter.new(device.results, "#{device.serial}_#{opts[:report]}")
      }
    end
  end
end
