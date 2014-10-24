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
        result = device.shell(instrument_command(runnable_test))
        File.open("results/logs/#{runnable_test.name}.log", 'w+') do |file|
          file.write device.logcat
        end
        Rubotium::TestResult.new(Rubotium::Adb::Parsers::TestResultsParser.new(result), runnable_test)
      end

      private

      attr_reader :device, :test_package

      def instrument_command (runnable_test)
        "am instrument -w -r -e class #{runnable_test.name} #{test_package.name}/#{test_package.test_runner}"
      end
    end
  end
end
