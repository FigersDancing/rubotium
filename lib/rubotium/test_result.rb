module Rubotium
  class TestResult

    attr_reader :stack_trace, :time, :error_message, :status, :test_name, :class_name, :device

    def initialize(test_results_parser, runnable_test)
      @parsed_result  = test_results_parser
      @class_name     = runnable_test.package_name
      @test_name      = runnable_test.test_name
    end

    def name
      "#{class_name}##{test_name}"
    end

    def stack_trace
      if(failed_run?)
        parsed_result.message
      else
        test_case.stack_trace
      end
    end

    def failed?
      failed_run? || test_case.failed?
    end

    def passed?
      not failed_run? and test_case.passed?
    end

    def errored?
      failed_run? || test_case.errored?
    end

    def error_message
      stack_trace
    end

    def time
      parsed_result.time
    end

    private

    attr_reader :parsed_result

    def failed_run?
      parsed_result.failed?
    end

    def test_case
      parsed_result.test_results.first
    end
  end
end
