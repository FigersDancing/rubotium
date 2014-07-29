module Rubotium
  module Adb
    class Shell
      ADB = 'adb'
      attr_reader :device_serial

      def initialize(device_serial)
        @device_serial = device_serial
      end

      def run_command command_to_run
        CMD.run_command(command + " " + command_to_run)
      end

      private
        def command
          [ADB, device, 'shell'].compact.join(" ")
        end

        def device
          if device_serial && !device_serial.empty?
            ['-s', device_serial]
          else
            nil
          end
        end

    end
  end
end