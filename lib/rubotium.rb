require 'rubotium/version'
require 'rubotium/jar_reader'
require 'rubotium/adb'
require 'rubotium/apk'
require 'rubotium/cmd'
require 'rubotium/device'
require 'rubotium/devices'
require 'rubotium/tests_runner'
require 'rubotium/formatters/junit_formatter'
require 'rubotium/grouper'
require 'rubotium/test_case'
require 'rubotium/test_suite'
require 'rubotium/runnable_test'
require 'rubotium/package'
require 'rubotium/memory'
require 'rubotium/adb/parsers/procrank'
require 'rubotium/test_runners/instrumentation_test_runner'
require 'rubotium/test_results'

require 'fileutils'
require 'mkmf'
require 'json'
require 'logger'

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

      logger.level = Logger::INFO

      startTime = Time.now
      FileUtils.mkdir_p('results')
      FileUtils.mkdir_p('results/memory_logs')

      application_package = Rubotium::Package.new(opts[:app_apk_path])
      tests_package       = Rubotium::Package.new(opts[:tests_apk_path], opts[:runner])

      if (opts[:tests_jar_path])
        test_suites  = JarReader.new(opts[:tests_jar_path]).get_tests
      else
        path_to_jar = File.join(Dir.mktmpdir, 'tests.jar')
        begin
          puts("Convertig dex to jar")
          Rubotium::Apk::Converter.new(tests_package.path, path_to_jar).convert_to_jar
          puts("Reading jar content")
          test_suites = JarReader.new(path_to_jar).get_tests
        ensure
          FileUtils.remove_entry(path_to_jar)
        end
      end
      puts "There are #{test_suites.count} tests to run"
      devices = Devices.new(:name => opts[:device_matcher]).all

      devices = Parallel.map(devices, :in_threads => devices.count) {|device|
        device.uninstall application_package.name
        device.install application_package.path
        device.uninstall tests_package.name
        device.install tests_package.path
        device
      }

      runner = Rubotium::TestsRunner.new(devices, test_suites, tests_package)
      runner.run_tests

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

      Formatters::JunitFormatter.new(runner.tests_results.group_by_package, opts[:report])

    end

    def logger
      @@logger ||= Logger.new(STDOUT).tap do |log|
        log.progname = 'name-of-subsystem'
      end
    end
  end
end
