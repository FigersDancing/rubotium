module Rubotium
  module Adb
    class Devices

      def attached
        get_device_list.map{|device_serial|
          create_device(device_serial)
        }
      end

      private
      def create_device(device_serial)
        Device.new(device_serial)
      end

      def adb_devices_command
        CMD.run_command('adb kill-server')
        wait_for_adb
        CMD.run_command('adb start-server')
        wait_for_adb
        CMD.run_command('adb devices', { :timeout => 5 } ).result
      end

      def wait_for_adb
        sleep 2
      end

      def get_device_list
        tries = 10
        while (tries > 0 && (list = adb_devices_command.split("\n")[1..-1]).empty?)
          tries -= 1
        end
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
