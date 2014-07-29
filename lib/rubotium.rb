require 'rubotium/version'
require 'rubotium/jar_reader'
require 'rubotium/adb'
require 'rubotium/cmd'
require 'rubotium/device'
require 'rubotium/devices'
require 'rubotium/formatters/junit_formatter'
require 'rubotium/grouper'

require 'parallel'
module Rubotium
  class Error < StandardError; end

  class NoDevicesError < Error; end

  class NoMatchedDevicesError < Error; end

  class NoTestSuiteError < Error; end

  class << self
    def new(opts = {})
      raise RuntimeError, "Empty configuration" if opts.empty?
      jar_reader = JarReader.new(opts[:tests_apk])
      tests      = jar_reader.get_tests

      tests_count = 0
      tests.each{|_,tests|
        tests_count = tests_count + tests.count
      }

      puts "There are #{tests.count} packages with tests in the Jar file"
      puts "#{tests_count} tests to run"

      devices = Devices.new(opts[:device_matcher]).all
      tests   = Grouper.new(tests).create_groups(devices.count)

      devices.each_with_index{|device, index|
        device.test_package_name = "com.android.tests"
        device.test_runner_name  = "com.android.tests.RandomizingRunner"
        device.testsuite         = tests[index]
      }

      startTime = Time.now
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
