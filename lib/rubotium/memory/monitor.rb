require_relative 'data_point'

module Rubotium
  module Memory
    class Monitor
      def initialize(device, opts = {})
        @device       = device
        @process_name = opts.delete(:process_name) || nil
        @interval     = opts.delete(:interval) || 0
      end

      def start
        @should_pool_memory = !!process_name
        start_probing_memory
      end

      def stop_and_save(io)
        stop
        io.write("[#{data_points.join(',')}]")
        reset
      end

      def stop
        @should_pool_memory = false
        start_probing_memory.join
        Rubotium.logger.debug("Memory collector stopped")
      end

      def data_points
        data.clone
      end

      def reset
        @data = []
      end

      private

      attr_reader :device, :interval, :process_name
      attr_accessor :should_pool_memory

      def start_probing_memory
        @pooling_thread ||= Thread.new do
          while @should_pool_memory do
            data.push(DataPoint.new(time, probe_memory))
            sleep interval
          end
        end
      end

      def data
        @data ||= []
      end

      def time
        Time.at(Time.now).strftime("%H:%M:%S")
      end

      def probe_memory
        device.shell(Rubotium::Adb::Commands::MemoryCommand.new(process_name).executable_command)
      end

    end
  end
end
