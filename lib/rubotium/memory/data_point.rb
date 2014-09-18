require 'json'
module Rubotium
  module Memory
    class DataPoint
      attr_reader :time

      def initialize(time, data_struct)
        @time = time
        @data_struct = data_struct
      end

      def pid
        parsed_result.pid
      end

      def vss
        parsed_result.vss
      end

      def rss
        parsed_result.rss
      end

      def pss
        parsed_result.pss
      end

      def uss
        parsed_result.uss
      end

      def cmdline
        parsed_result.cmdline
      end

      def to_s
        to_json.to_json
      end

      def to_json
        {
          :time => time,
          :pid  => pid,
          :vss  => vss,
          :rss  => rss,
          :uss  => uss,
          :cmd  => cmdline
        }
      end

      private
      attr_reader :data_struct

      def parsed_result
        @parsed_result ||= parser.parse
      end

      def parser
        Rubotium::Adb::Parsers::Procrank.new(data_struct)
      end
    end
  end
end
