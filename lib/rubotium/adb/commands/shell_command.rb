module Rubotium
  module Adb
    module Commands
      class ShellCommand
        COMMAND = 'shell'

        def initialize(command)
          @command = command
        end

        def executable_command
          "#{COMMAND} #{command}"
        end

        private

        attr_reader :command
      end
    end
  end
end
