module Rubotium
  class Device
    attr_accessor :testsuite, :test_queue
    attr_reader   :serial, :results
    def initialize(serial, test_runner)
      @serial     = serial
      @runner     = test_runner
      @retry      = 1
      @results    = {}
    end

    def test_runner_name= name
      runner.test_runner = name
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
    attr_reader :runner, :command, :serial

    def adb_command
      @command ||= Rubotium::Adb::Commands::Command.new(serial)
    end
  end
end
