module Rubotium
  module Adb
    module Parsers
      class TestResultsParser
        PATTERN = Regexp.new('(INSTRUMENTATION_STATUS_CODE: 1.*?INSTRUMENTATION_STATUS_CODE: -?\d)',  Regexp::MULTILINE)
        TIME_PATTERN = Regexp.new('Time: (.*)')
        SHORT_MESSAGE_PATTERN = Regexp.new('INSTRUMENTATION_RESULT: shortMsg=(.*)')
        LONG_MESSAGE_PATTERN  = Regexp.new('INSTRUMENTATION_RESULT: longMsg=(.*)')
        ERROR_MESSAGE_PATTERN = Regexp.new('INSTRUMENTATION_STATUS: Error=(.*)')

        def initialize(results)
          @results    = results
        end

        def test_results
          tests.map{|result|
            create_single_test_result_parser(result)
          }
        end

        def count
          tests.count
        end

        def failed?
          count == 0
        end

        def successful?
          count > 0
        end

        def time
          match_time.strip
        end

        def message
          [error_message, short_message, long_message].compact.join("\n")
        end

        private
        attr_reader :results
        def tests
          @tests ||= results.scan(PATTERN).flatten
        end

        def match_time
          results[TIME_PATTERN, 1] || '0'
        end

        def error_message
          results[ERROR_MESSAGE_PATTERN, 1]
        end

        def short_message
          results[SHORT_MESSAGE_PATTERN, 1]
        end

        def long_message
          results[LONG_MESSAGE_PATTERN, 1]
        end

        def create_single_test_result_parser(result)
          Rubotium::Adb::Parsers::SingleTestResultParser.new(result)
        end
      end
    end
  end
end
