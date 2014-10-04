module Rubotium
  module Adb
    module Parsers
      class SingleTestResultParser
        STATUS_CODE_PATTERN   = Regexp.new('.*INSTRUMENTATION_STATUS_CODE: (-?\d)$', Regexp::MULTILINE)
        STACK_TRACE__PATTERN  = Regexp.new('INSTRUMENTATION_STATUS: stack=(.*)INSTRUMENTATION_STATUS:', Regexp::MULTILINE)
        TEST_NAME_PATTERN     = Regexp.new('INSTRUMENTATION_STATUS: test=(.*)$')
        CLASS_NAME_PATTERN    = Regexp.new('INSTRUMENTATION_STATUS: class=(.*)$')
        ERROR_STATUS = 'ERROR'
        FAIL_STATUS  = 'FAIL'
        OK_STATUS    = 'OK'

        attr_reader :result, :stack_trace, :time, :error_message, :status, :package_name

        def initialize(test_result)
          @result = test_result
        end

        def class_name
          match_class_name.strip
        end

        def test_name
          match_test_name.strip
        end

        def failed?
          result[STATUS_CODE_PATTERN, 1] == '-2'
        end

        def passed?
          result[STATUS_CODE_PATTERN, 1] == '0'
        end

        def errored?
          result[STATUS_CODE_PATTERN, 1] == '-1'
        end

        def stack_trace
          match_stack_trace.strip
        end

        private

        attr_reader :result

        def match_class_name
          result[CLASS_NAME_PATTERN, 1]
        end

        def match_test_name
          result[TEST_NAME_PATTERN, 1]
        end

        def match_stack_trace
          result[STACK_TRACE__PATTERN, 1] || ''
        end
      end
    end
  end
end
