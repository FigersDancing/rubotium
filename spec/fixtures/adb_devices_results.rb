module Fixtures
  class Adb
    module Devices
      class << self
        def two_devices_attached_one_is_offline
          "List of devices attached \nemulator-5554\toffline\nemulator-5556\tdevice\n\n"
        end

        def two_devices_attached
          "List of devices attached \nemulator-5554\tdevice\nemulator-5556\tdevice\n\n"
        end

        def one_device_attached_and_offline
          "List of devices attached \nemulator-5554\toffline\n\n"
        end

        def one_device_attached
          "List of devices attached \nemulator-5554\tdevice\n\n"
        end

        def no_devices_attached
          "List of devices attached \n\n"
        end
      end
    end
  end
end
