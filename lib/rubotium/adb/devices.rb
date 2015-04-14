module Rubotium
  module Adb
    class Devices

      def attached
        parse.map{|device_serial|
          create_device(device_serial)
        }
      end

      private
      def create_device(device_serial)
        Device.new(device_serial)
      end

      def adb_devices_command
        CMD.run_command('adb devices', { :timeout => 5 } ).result
      end

      def parse
        list = adb_devices_command.split("\n")
        list.shift
        attached_devices list
      end

      def attached_devices(list)
        list.collect { |device|
          parts = device.split("\t")
          parts.last == 'device' ? parts.first : nil
        }.compact
      end
    end
  end
end
