module Rubotium
  class Device
    attr_accessor :testsuite
    attr_reader   :serial, :results
    def initialize(serial, test_runner)
      @runner   = test_runner
      @retry    = 1
      @serial   = serial
      @results  = {}
    end

    def test_runner_name= name
      runner.test_runner = name
    end

    def test_package_name= name
      runner.test_package_name = name
    end

    def run_tests
      raise(NoTestSuiteError, "Please setup test suite before running tests") if testsuite.nil?
      puts "Running tests"
      testsuite.each{|package_name, tests|
        @results[package_name] = []
        puts "Test package: #{package_name}"
        tests.each{|test|
          run_count = 0
          puts "TEST: #{package_name} #{test}"
          while ((result = runner.run_test(package_name, test)) && (result.failed? || result.errored?) && run_count < @retry ) do
            puts "RERUNNING TEST: #{package_name} #{test}, STATUS: #{result.status}"
            run_count += 1
          end
          puts "FINISHED with status: #{result.status}"
          @results[package_name].push(result)
        }
      }
    end

    private
    attr_reader :runner
  end
end