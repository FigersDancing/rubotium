module Rubotium
  class Device
    attr_reader   :serial
    def initialize(serial)
      @serial     = serial
    end

    def name
      @name ||= adb_command.shell('getprop ro.product.model').strip
    end

    def install(apk_path)
      adb_command.install(apk_path)
    end

    def uninstall(package_name)
      adb_command.uninstall(package_name)
    end

    def pull(path)
      adb_command.pull(path)
    end

    def shell(command)
      adb_command.shell(command)
    end

    private
    attr_reader :command

    def adb_command
      @command ||= Rubotium::Adb::Commands::Command.new(serial)
    end
  end
end
