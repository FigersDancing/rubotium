require 'builder'
require 'uri'

module Rubotium
  module Formatters
    class HtmlFormatter
      attr_reader :html
      def initialize(results, path_to_file)
        @results          = results
        @report_file_path = path_to_file

        @html = Builder::XmlMarkup.new :target => ensure_io(report_path), :indent => 2
        inline_css

        html.body do
          results.each{|package_name, tests|
            start_test_suite(package_name, tests)
            }
        end
      end

      def inline_css
        html.style(:type => 'text/css') do
        html << File.read(File.dirname(__FILE__) + '/html_formatter.css')
        end
      end

      private
      attr_reader :report_file_path, :device_serial, :results
      def start_test_suite(package_name, tests)
        failures    = get_failures(tests)
        errors      = get_errors(tests)
        tests_time  = get_tests_time(tests)
        tests_count = tests.count

        html.ul(:class => 'testsuites') do
          html.li(:class => 'testsuite') do
            html.span(package_name)
            html.ul do
              tests.each { |test|
                print_testcase(test)
              }
            end
          end
        end
      end

      def print_testcase(test)
        html.li(:class => 'test_case') do
          html.span(test.test_name)
          html.ul do
            html.li(:class => 'stderr') do
              html.span(:class => 'stderr') do
                html.text!(test.stack_trace)
              end
            end
            html.li(:class => 'logcat') do
               html.a("logcat", :href=> URI.encode("logs/#{test.class_name}##{test.test_name}.log"))
            end

          end
        end
      end

      def has_failures(test)
        if test.failed?
          html.failure :message=>"", :type=>"" do
            html.cdata! test.stack_trace
          end
        end
      end

      def has_errors(test)
        if test.errored?
          html.error :message=>"", :type=>"" do
            html.cdata! test.error_message
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

      def report_path
        report_file_path
      end

      def ensure_io(path_to_file)
        File.open(path_to_file, 'w')
      end
    end
  end
end
