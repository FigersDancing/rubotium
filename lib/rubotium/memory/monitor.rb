require_relative 'data_point'

module Rubotium
  module Memory
    class Monitor
      def initialize(device, opts = {})
        @device   = device
        @interval = opts.delete(:interval) || 0
      end

      def start
        should_pool_memory = true
        Thread.new do
          while should_pool_memory do
            data.push(DataPoint.new(time, probe_memory))
            sleep interval
          end
        end
      end

      def stop
        should_pool_memory = false
      end

      def data_points
        data.clone
      end

      def reset
        @data = nil
      end

      private

      attr_reader :device, :interval
      attr_accessor :should_pool_memory

      def data
        @data ||= []
      end

      def time
        Time.at(Time.now).utc.strftime("%H:%M:%S")
      end

      def probe_memory
        device.shell(Rubotium::Adb::Commands::MemoryCommand.new('com.soundcloud.android').executable_command)
      end

    end
  end
end
