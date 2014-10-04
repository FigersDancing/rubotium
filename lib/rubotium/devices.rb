module Rubotium
  class Devices
    def initialize(options = {})
      @match_serial = options[:serial]  || ''
      @match_name   = options[:name]    || ''
    end

    def all
      raise NoDevicesError if attached_devices.empty?
      raise NoMatchedDevicesError if matched_by_name.empty?
      (matched_by_name + matched_by_serial).uniq
    end

    private
    attr_reader :matched, :attached_devices, :match_name, :match_serial

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

    def adb_devices
      Adb::Devices.new
    end

  end
end
