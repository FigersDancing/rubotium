module Rubotium
  class Devices
    def initialize(options = {})
      @match_serial = options[:serial]  || ''
      @match_name   = options[:name]    || ''
      @match_sdk    = options[:sdk]     || ''
    end

    def all
      raise NoDevicesError if attached_devices.empty?
      raise NoMatchedDevicesError if matched_devices.empty?
      matched_devices
    end


    private
    attr_reader :matched, :attached_devices, :match_name, :match_serial, :match_sdk

    def matched_devices
      @matched_devices ||=(matched_by_name + matched_by_serial + matched_by_sdk).uniq
    end

    def attached_devices
      @attached_devices ||= adb_devices.attached
    end

    def matched_by_serial
      attached_devices.select { |device|
        device.serial.eql? match_serial
      }
    end

    def matched_by_name
      attached_devices.select { |device|
        device.name.include? match_name
      }
    end

    def matched_by_sdk
      attached_devices.select { |device|
        device.sdk.eql? match_sdk
      }
    end

    def adb_devices
      Adb::Devices.new
    end

  end
end
