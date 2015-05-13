require 'ostruct'

module Rubotium
  module TestRunners
    class InstrumentationTestRunner
      def initialize(device, test_package, options = {}, log_writter = LogWritter.new)
        @device         = device
        @test_package   = test_package
        @annotations    = options.delete(:annotation)
        @log_writter    = log_writter
      end

      def run_test(runnable_test)
        device.clean_logcat
        result = execute(instrument_command(runnable_test))
        log_writter.save_to_file(runnable_test.name, device.logcat)
        Rubotium::TestResult.new(result , runnable_test)
      end

      private

      attr_reader :device, :test_package, :log_writter

      def execute(command)
        cmd_result = device.shell(command)
        if (cmd_result.status_code == 1)
          OpenStruct.new(
            test_results: [],
            count: 0,
            failed?: true,
            successful?: false,
            time: 0,
            message: "test timed out"
          )
        else
          Rubotium::Adb::Parsers::TestResultsParser.new(cmd_result.result)
        end
      end

      def instrument_command (runnable_test)
        "am instrument -w -r -e class #{runnable_test.name} #{test_package.name}/#{test_package.test_runner}"
      end
    end
  end
end
