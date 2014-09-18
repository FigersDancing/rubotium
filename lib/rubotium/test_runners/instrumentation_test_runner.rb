module Rubotium
  module TestRunners
    class InstrumentationTestRunner
      def initialize(device, test_package)
        @device         = device
        @test_package   = test_package
      end

      def run_test(runnable_test)
        result = device.shell(instrument_command(runnable_test))
        Rubotium::Adb::TestResultParser.new(result, runnable_test, device.name)
      end

      private

      attr_reader :device, :test_package

      def instrument_command (runnable_test)
        "am instrument -w -e class #{runnable_test.name} #{test_package.name}/#{test_package.test_runner}"
      end
    end
  end
end
