module Rubotium
  class Devices
    def initialize(options)
      @attached_devices = Adb::Devices.new.attached
      @match_serial     = options[:serial]
      @match_name       = options[:name]
    end

    def all
      raise NoDevicesError if attached_devices.empty?
      # raise NoMatchedDevicesError if matched.empty?
      matched_by_name
    end

    private
      attr_reader :matched, :attached_devices, :match_name

      def matched_devices(device_matcher)
        device_matcher ? attached_devices.select{|device|
          device.include? device_matcher
        } : attached_devices
      end

      def matched_by_name
        attached_devices.select{|device|
          device.name.include? match_name
        }
      end

  end
end