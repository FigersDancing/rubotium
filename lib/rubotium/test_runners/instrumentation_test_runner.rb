module Rubotium
  module TestRunners
    class InstrumentationTestRunner
      def initialize(device, test_package, options = {})
        @device         = device
        @test_package   = test_package
        @annotations    = options.delete(:annotation)
      end

      def run_test(runnable_test)
        device.clean_logcat
        result = execute(instrument_command(runnable_test))
        File.open("results/logs/#{runnable_test.name}.log", 'w+') do |file|
          file.write device.logcat
        end
        Rubotium::TestResult.new(result , runnable_test)
      end

      private

      attr_reader :device, :test_package

      def execute(command)
        cmd_result = device.shell(command)
        if (cmd_result.status_code == 1)
          Struct.new(
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
