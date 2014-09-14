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
require 'rubotium/memory'
require 'rubotium/adb/parsers/procrank'

require 'fileutils'
require 'mkmf'

require 'parallel'
module Rubotium
  class Error < StandardError; end

  class NoDevicesError < Error; end

  class NoMatchedDevicesError < Error; end

  class NoTestSuiteError < Error; end

  class NoAaptError < Error; end

  class NoJavapError < Error; end

  class << self
    def new(opts = {})
      raise RuntimeError,   "Empty configuration"       if opts.empty?
      raise NoJavapError,   "No javap tool in $PATH"    if !find_executable('javap')
      raise NoAaptError,    "No aapt tool in $PATH"     if !find_executable('aapt')
      raise Errno::ENOENT,  "Tests apk does not exist"  if !File.exist?(opts[:tests_apk_path])
      raise Errno::ENOENT,  "App apk does not exist"    if !File.exist?(opts[:app_apk_path])

      startTime = Time.now
      application_package = Rubotium::Package.new(opts[:app_apk_path])
      tests_package       = Rubotium::Package.new(opts[:tests_apk_path])
      test_runner         = opts[:runner]
      #
      # if (opts[:tests_jar_path])
      #   test_suites  = JarReader.new(opts[:tests_jar_path]).get_tests
      # else
      #   path_to_jar = File.join(Dir.mktmpdir, 'tests.jar')
      #   begin
      #     puts("Convertig dex to jar")
      #     Rubotium::Apk::Converter.new(tests_package.path, path_to_jar).convert_to_jar
      #     puts("Reading jar content")
      #     test_suites = JarReader.new(path_to_jar).get_tests
      #   ensure
      #     FileUtils.remove_entry(path_to_jar)
      #   end
      # end



      # tests_count = 0
      # test_suites.each{|test_suite|
      #   tests_count = tests_count + test_suite.test_cases.count
      # }

      # puts "There are #{test_suites.count} packages with tests in the Jar file"
      # puts "#{tests_count} tests to run"

      test_queue = Queue.new
      test_queue.push(RunnableTest.new('com.soundcloud.android.auth.signup.SmartFields', 'testDoneButtonBehavior'))
      test_queue.push(RunnableTest.new('com.soundcloud.android.explore.Explore', 'testTendingMusicLoadsNextPage'))
      devices = Devices.new(:name => opts[:device_matcher]).all

      # test_suites.each{|test_suite|
      #   test_suite.test_cases.map{|test|
      #     test_queue.push(RunnableTest.new(test_suite.name, test.name))
      #   }
      # }

      memorymonitor = Rubotium::Memory::Monitor.new(devices.first, {:interval => 0})

      devices.each{|device|
        device.test_package_name = tests_package.name
        device.test_runner_name  = test_runner || "android.test.InstrumentationTestRunner"
        device.test_queue        = test_queue
      }

      devices = Parallel.map(devices, :in_threads => devices.count) {|device|
        device.uninstall application_package.name
        device.install application_package.path
        device.uninstall tests_package.name
        device.install tests_package.path
        memorymonitor.start
        device.run_tests
        device
      }

      memorymonitor.data_points.each{|data_point|
        p "#{data_point.time}: #{data_point.pss}"
      }

      results = {}
      devices.each{|device|
        device.results.each{|package_name, tests|
          results[package_name] = [] unless results[package_name]
          results[package_name].push(tests)
          results[package_name]
        }
      }

      FileUtils.mkdir_p(['screens', 'logs'])

      devices.each{|device|
        device.pull('/sdcard/Robotium-Screenshots')
        device.pull('/sdcard/RobotiumLogs')
        device.shell('rm -R /sdcard/Robotium-Screenshots ')
        device.shell('rm -R /sdcard/RobotiumLogs ')
      }
      FileUtils.mv(Dir.glob('*.jpg'), 'screens')
      FileUtils.mv(Dir.glob('*.log'), 'logs')

      puts "Tests took: #{Time.at(Time.now-startTime).utc.strftime("%H:%M:%S")}"
      Formatters::JunitFormatter.new(results, opts[:report])

    end
  end
end
