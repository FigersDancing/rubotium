require 'timeout'
module Rubotium
  class CMD
    attr_reader :read, :write
    attr_reader :command_to_run, :buffer, :pid

    class << self

      def run_command(command_to_run, opts = {})
        begin
          Timeout::timeout(opts[:timeout] || 10*60) {
            Rubotium.logger.debug "[EXECUTING]: #{command_to_run}"
            new(command_to_run).execute
          }
        rescue Timeout::Error
          CmdResult.new(1, '')
        end
      end
    end

    def initialize(command_to_run)
      @command_to_run = command_to_run
      @read, @write = IO.pipe
      @buffer = ''
    end

    def execute
      spawn_process
      read_buffer
      _, status = Process.waitpid2(pid)
      CmdResult.new(status, buffer)
    end

    def read_buffer
      while (!read.closed? && !read.eof? && line=read.readline)
        buffer << line
      end
    end

    def spawn_process
      @pid = spawn(command_to_run, out: write, err: write)
      write.close
    end
  end
end
