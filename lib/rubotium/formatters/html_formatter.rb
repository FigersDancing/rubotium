require 'builder'
require 'uri'

module Rubotium
  module Formatters
    class HtmlFormatter
      attr_reader :html
      def initialize(results, path_to_file)
        @test_results          = results
        @report_file_path = path_to_file

        @html = Builder::XmlMarkup.new :target => ensure_io(report_path), :indent => 2
        inline_css
        add_header
        add_body
        add_footer
      end

      private
      attr_reader :report_file_path, :device_serial, :test_results

      def inline_css
        # html.link(:rel=>"stylesheet", :href=> (File.dirname(__FILE__) + '/html_formatter.css'))
        html.style(:type => 'text/css') do
          html << File.read(File.dirname(__FILE__) + '/html_formatter.css')
        end
      end

      def add_header
        html.div(:id => 'header') do
          display_time
          display_info
        end
      end

      def display_info
        html.h1 do
          html.text('All tests:')
          html.strong do
            html.span("#{test_results.total} total,")
            html.span("#{test_results.passed} passed,", { :class => 'passed' })
            html.span("#{test_results.failed} failed", { :class => 'error' }) if test_results.failed

          end
        end
      end

      def display_time
        html.div(format_time(test_results.time.to_i), { :class => 'time' })
      end

      def add_body
        html.body do
          add_content
        end
      end

      def add_footer

      end

      def add_content
        html.div(:id => 'content') do
          html.ul(:id => 'testsuites') do
            test_results.each{|suite|
              start_test_suite(suite)
            }
          end
        end
      end

      def start_test_suite(suite)
          html.li(:class => 'testsuite') do
            html.div(:class => suite.state) do
              html.span(suite.name)
            end

            html.ul do
              suite.each_test { |test|
                html << TestCaseHtml.new(test).target
              }
            end

          end
      end

      def report_path
        report_file_path
      end

      def ensure_io(path_to_file)
        File.open(path_to_file, 'w')
      end

      def format_time(seconds)
        return '0 s' if seconds == 0
        [[60, :s], [60, :m], [24, :h]].map{ |count, name|
          if seconds > 0
            seconds, n = seconds.divmod(count)
            "#{n.to_i} #{name}"
          end
        }.compact.reverse.join(' ')
      end

      class TestCaseHtml
        def initialize(test_result)
          @test_result = test_result
          @builder = Builder::XmlMarkup.new(:indent => 2)
        end

        def target
          html
        end

        private
        attr_reader :test_result, :builder

        def html
          builder.li(:class => 'test_case') do
            print_name
            builder.ul do
              unless test_result.passed?
                print_stacktrace
                print_logcat
                print_screen_record if File.exist?(File.join(Dir.pwd, 'results', video_file))
              end
            end
          end
        end

        def print_stacktrace
          builder.li(:class => 'stderr') do
            test_result.stack_trace.each_line{|line|
              builder.br
              builder.span(line)
            }
          end
        end

        def print_logcat
          builder.li(:class => 'logcat') do
            builder.a("full log", :href => URI.encode(logcat_file))
          end
        end

        def print_screen_record
          builder.li(:class => 'screencast') do
            builder.video({ :width => "240", :height => "320", :controls => true }) do
              builder.source({ :src => URI.encode(video_file), :type => "video/mp4" })
            end
          end
        end

        def print_name
          builder.div(:class => test_result.passed? ? 'passed' : 'failed') do
            builder.div(format_time(test_result.time), { :class => 'time' })
            builder.span(test_result.test_name)
          end
        end

        def logcat_file
          "logs/#{test_result.name}.log"
        end

        def video_file
          "screencasts/#{test_result.name}.mp4"
        end

        def format_time(seconds)
          return '0 s' if seconds == 0
          [[60, :s], [60, :m], [24, :h]].map{ |count, name|
            if seconds > 0
              seconds, n = seconds.divmod(count)
              "#{n.to_i} #{name}"
            end
          }.compact.reverse.join(' ')
        end
      end
    end
  end
end
