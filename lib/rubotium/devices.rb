module Rubotium
  class Devices
    def initialize(device_matcher = '')
      @attached_devices = Adb::Devices.new.list
      @matched          = matched_devices device_matcher
    end

    def all
      raise NoDevicesError if attached_devices.empty?
      raise NoMatchedDevicesError if matched.empty?
      matched.map{|device|
        Device.new(device, Adb::Instrumentation.new(device))
      }
    end

    private
      attr_reader :matched, :attached_devices

      def matched_devices(device_matcher)
        device_matcher ? attached_devices.select{|device|
          device.include? device_matcher
        } : attached_devices
      end
  end
end