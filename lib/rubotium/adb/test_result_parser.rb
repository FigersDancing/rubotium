module Rubotium
  module Adb
    class TestResultParser
      ERROR_STATUS = 'ERROR'
      FAIL_STATUS  = 'FAIL'
      OK_STATUS    = 'OK'

      attr_reader :result, :stack_trace, :time, :error_message, :status, :package_name, :test_name

      def initialize(result, package_name, test_name)
        @result       = result
        @package_name = package_name
        @test_name    = test_name
        parse
      end

      def failed?
        @status == FAIL_STATUS
      end

      def passed?
        @status == OK_STATUS
      end

      def errored?
        @status == ERROR_STATUS
      end

      private
        def parse
          if ENV['DEBUG']
            p result
          end
          @stack_trace    = has_failed?   ? get_stack_trace : ""
          @status         = get_status
          @time           = has_errored?  ? 0 : get_time
          @error_message  = has_errored?  ? get_error : ""
        end

        def get_status
          if has_errored?
            ERROR_STATUS
          elsif has_failed?
            FAIL_STATUS
          else
            OK_STATUS
          end
        end

        def has_errored?
          (result.include? 'INSTRUMENTATION_RESULT') || (result.include? 'INSTRUMENTATION_STATUS')
        end

        def has_failed?
          result.include? 'FAILURES'
        end

        def get_time
          result.match(/Time: (-?\d+.\d+)/)[1].to_f.abs
        end

        def get_stack_trace
          result.split("\r\n\r\n")[0].split(/^/)[3..-1].join
        end

        def get_error
          if instrumentation_error
            result.match(/INSTRUMENTATION_RESULT: longMsg=(.*)\r/)[1]
          else
            result.match(/INSTRUMENTATION_STATUS: Error=(.*)\r/)[1]
          end

        end
        def application_error
          result.match(/INSTRUMENTATION_RESULT: longMsg=(.*)\r/) == nil
        end

        def instrumentation_error
          result.match(/INSTRUMENTATION_STATUS:/) == nil
        end
    end
  end
end