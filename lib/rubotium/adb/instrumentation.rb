module Rubotium
  module Adb
    class NoTestRunnerError < StandardError; end
    class NoTestPackageError < StandardError; end

    class Instrumentation
      attr_accessor :test_package_name, :test_runner
      attr_reader :adb_shell

      def initialize(device)
        @adb_shell = Rubotium::Adb::Shell.new(device)
      end

      def run_test(runable_test)
        check_packages
        result = adb_shell.run_command(instrument_command(runable_test.package_name, runable_test.test_name))
        TestResultParser.new(result, runable_test.package_name, runable_test.test_name)
      end

      private
      def instrument_command package_name, test_name
        "am instrument -w -e class #{class_test(package_name, test_name)} #{test_package_name}/#{test_runner}"
      end

      def class_test package_name, test_name
        "#{package_name}##{test_name}"
      end

      def check_packages
        raise NoTestRunnerError   if !test_runner
        raise NoTestPackageError  if !test_package_name
      end

    end
  end
end