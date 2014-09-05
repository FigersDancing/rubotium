module Rubotium
  module Adb
    class PullCommand
      COMMAND = 'pull'
      def initialize(path)
        @path = path
      end

      def executable_command
        "#{COMMAND} #{path}"
      end

      private
      attr_reader :path
    end
  end
end
