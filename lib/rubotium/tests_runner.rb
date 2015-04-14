require 'parallel'
module Rubotium
  class TestsRunner
    def initialize(devices, tests, tests_package, options = {})
      @devices        = devices
      @tests          = tests
      @tests_package  = tests_package
      @tests_runner   = tests_package.test_runner
      @options        = options
      @clear          = options[:clear]
      @test_number    = 0
    end

    def tests_count
      tests.count
    end

    def tests_to_execute
        tests_queue.count
    end

    def tests_results
      Rubotium::TestResults.new(results)
    end

    def run_tests
      fill_tests_queue
      Parallel.each(devices, :in_threads => devices.count) { |device|
        while(test = next_test)
          memory_monitor = Rubotium::Memory::Monitor.new(device, { :interval => 1 })
          memory_monitor.start
          display_test_progress
          result = test_runner(device).run_test(test)
          if(result.failed? || result.errored?)
            screencast = Rubotium::Recorder.new(device.serial)
            screencast.start(test.name)
            result = test_runner(device).run_test(test)
            screencast.stop
          end
          results.push(result)
          clear_if_required(device)
          memory_monitor.stop_and_save(memory_results_file(test))
        end
      }
    end

    def display_test_progress
      @test_number += 1
      puts "Running test: #{@test_number} out of #{tests_count}"
    end

    private

    attr_reader :devices, :tests_package, :tests, :clear

    def memory_results_file(test)
      File.open("results/memory_logs/#{test.name}.json", 'w+')
    end

    def results
      @results ||= []
    end

    def next_test
      tests_queue.pop(true) rescue nil
    end

    def fill_tests_queue
      tests.map { |test| tests_queue.push(test) }
    end

    def tests_queue
      @queue ||= Queue.new
    end

    def clear_if_required(device)
      device.shell("pm clear #{clear}") if clear
    end

    def test_runner(device)
      Rubotium::TestRunners::InstrumentationTestRunner.new(device, tests_package)
    end

    def retrying_test_runner
      Rubotium::TestRunners::RetryingTestRunner.new(device, test)
    end
  end
end
