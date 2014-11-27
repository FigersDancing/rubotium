module Rubotium
  class Recorder
    SIGINT = 'SIGINT'

    def initialize(device_serial)
      @serial = device_serial
    end

    def start(test_name)
      @pid = Process.spawn(record_command(test_name))
      puts "Starting screencast, PID: #{@pid}"
    end

    def record_command(test_name)
      "adb -s #{serial} shell screenrecord /sdcard/screencasts/#{test_name}.mp4"
    end

    def stop
      puts "Stopping screencast, PID: #{@pid}"
      kill_children
      kill_self
    end

    private
    attr_reader :serial

    def kill_self
      Process.kill(SIGINT, @pid)
    end

    def kill_children
      find_child_processes.each{|pid|
        if pid > 0
          Process.kill(SIGINT, pid)
        end
      }
    end

    def find_child_processes
      `pgrep -P #{@pid}`.each_line.map(&:strip).map(&:to_i)
    end
  end
end
