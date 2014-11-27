module Rubotium
  class Device
    attr_reader   :serial, :sdk
    def initialize(serial)
      @serial     = serial
    end

    def name
      @name ||= adb_command.shell('getprop ro.product.model').strip
    end

    def sdk
      @sdk ||= adb_command.shell('getprop ro.build.version.sdk').strip
    end

    def clean_logcat
      adb_command.clean_logcat
    end

    def logcat
      adb_command.logcat
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
