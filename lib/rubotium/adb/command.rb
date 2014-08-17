module Rubotium
  module Adb
    class Command
      def initialize(device_serial)
        @device_serial = device_serial
      end

      def execute(command_to_run)
        puts "EXECUTING_COMMAND: #{adb_command} #{command_to_run.executable_command}"
        CMD.run_command(adb_command + " " + command_to_run.executable_command)
      end

      private
      attr_reader :device_serial

      def adb_command
        "adb -s #{device_serial} "
      end
    end
  end
end