module Rubotium
  module Adb
    class Devices
      attr_reader :list

      def initialize
        @list = parse(CMD.run_command('adb devices',{ :timeout => 5 } ))
      end

      private
      def parse result
        list = result.split("\n")
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