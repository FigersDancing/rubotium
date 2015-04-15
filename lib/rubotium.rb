require 'rubotium/version'
require 'rubotium/adb'
require 'rubotium/apk'
require 'rubotium/cmd'
require 'rubotium/cmd_result'
require 'rubotium/device'
require 'rubotium/devices'
require 'rubotium/tests_runner'
require 'rubotium/formatters/junit_formatter'
require 'rubotium/screencast'
require 'rubotium/formatters/html_formatter'
require 'rubotium/runnable_test'
require 'rubotium/package'
require 'rubotium/memory'
require 'rubotium/adb/parsers/procrank'
require 'rubotium/test_runners/instrumentation_test_runner'
require 'rubotium/test_results'
require 'rubotium/test_cases_reader'
require 'rubotium/test_result'

require 'fileutils'
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
      raise Errno::ENOENT,  "Tests apk does not exist"  if !File.exist?(opts[:tests_apk_path])
      raise Errno::ENOENT,  "App apk does not exist"    if !File.exist?(opts[:app_apk_path])
      if !opts[:helper_apk_path].nil?
        raise Errno::ENOENT,  "Helper apk does not exist" if !File.exist?(opts[:helper_apk_path])
      end

      logger.level = Logger::INFO

      startTime = Time.now
      FileUtils.mkdir_p('results/logs')
      FileUtils.mkdir_p('results/memory_logs')
      FileUtils.mkdir_p('results/screencasts')
      FileUtils.mkdir_p('screens')
      FileUtils.mkdir_p('logs')

      application_package = Rubotium::Package.new(opts[:app_apk_path])
      tests_package       = Rubotium::Package.new(opts[:tests_apk_path], opts[:runner])
      helper_package      = Rubotium::Package.new(opts[:helper_apk_path])

      devices = Devices.new(:name => opts[:device_matcher], :sdk => opts[:device_sdk], :serial=> opts[:serial]).all

      devices = Parallel.map(devices, :in_threads => devices.count) {|device|
        device.uninstall application_package.name
        device.install application_package.path
        device.uninstall tests_package.name
        device.install tests_package.path
        if !opts[:helper_apk_path].nil?
          device.uninstall helper_package.name
          device.install helper_package.path
        end
        device.shell('mkdir /sdcard/screencasts')
        device
      }

      test_suites = Rubotium::TestCasesReader.new(devices.first, tests_package, { :annotation=>opts[:annotation]}).read_tests

      puts "There are #{test_suites.count} tests to run"

      runner = Rubotium::TestsRunner.new(devices, test_suites, tests_package, {annotation: opts[:annotation], clear: application_package.name})
      runner.run_tests

      FileUtils.mkdir_p(['screens', 'logs'])

      devices.each{|device|
        device.pull('/sdcard/Robotium-Screenshots')
        device.pull('/sdcard/RobotiumLogs')
        device.pull('/sdcard/screencasts')
        device.shell('rm -R /sdcard/Robotium-Screenshots')
        device.shell('rm -R /sdcard/RobotiumLogs')
        device.shell('rm -R /sdcard/screencasts')
        device.shell('reboot')
      }
      FileUtils.mv(Dir.glob('*.jpg'), 'screens')
      FileUtils.mv(Dir.glob('*.log'), 'logs')
      FileUtils.mv(Dir.glob('*.mp4'), 'results/screencasts')

      puts "Tests took: #{Time.at(Time.now-startTime).utc.strftime("%H:%M:%S")}"

      Formatters::JunitFormatter.new(runner.tests_results.group_by_package, opts[:report])
      Formatters::HtmlFormatter.new(runner.tests_results.group_by_failures, 'results/index.html')
    end

    def logger
      @@logger ||= Logger.new(STDOUT).tap do |log|
        log.progname = 'name-of-subsystem'
      end
    end
  end
end
