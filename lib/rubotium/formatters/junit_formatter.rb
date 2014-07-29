require 'builder'

module Rubotium
  module Formatters
    class JunitFormatter
      attr_reader :xml
      def initialize(results, path_to_file)
        @xml = Builder::XmlMarkup.new :target => ensure_io(path_to_file), :indent => 2

        xml.testsuites do
          results.each{|package_name, tests|
            start_test_suite(package_name, tests)
          }
        end
      end
      private
        def start_test_suite(package_name, tests)
          failures    = get_failures(tests)
          errors      = get_errors(tests)
          tests_time  = get_tests_time(tests)
          tests_count = tests.count
          params = {
                    :errors     => errors,
                    :failures   => failures,
                    :name       => package_name,
                    :tests      => tests_count,
                    :time       => tests_time,
                    :timestamp  => Time.now
          }

          xml.testsuite(params) do
            tests.each { |test|
              print_testcase(test)
            }
          end
        end

        def print_testcase(test)
          xml.testcase :classname=>test.package_name, :name=>test.test_name, :time=>test.time do
            has_failures(test)
            has_errors(test)
          end
        end

        def has_failures(test)
          if test.failed?
            xml.failure :message=>"", :type=>"" do
              xml.cdata! test.stack_trace
            end
          end
        end

        def has_errors(test)
          if test.errored?
            xml.error :message=>"", :type=>"" do
              xml.cdata! test.error_message
            end
          end
        end

        def get_tests_time(tests)
          tests.inject(0){|time_sum, test| time_sum += test.time.to_f }
        end

        def get_errors(tests)
          tests.select{|test|
            test.errored?
          }.count
        end

        def get_failures(tests)
          tests.select{|test|
            test.failed?
          }.count
        end

        def ensure_io(path_to_file)
          File.open(path_to_file, 'w')
        end
    end
  end
end