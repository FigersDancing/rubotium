module Rubotium
  module Adb
    module Commands
      class PushCommand
        COMMAND = 'push'

        def initialize(local_glob, remote_dest)
          @local_paths = Dir[local_glob]
          @remote_dest = remote_dest
        end

        def executable_command
          local_paths.map do |path|
            "#{COMMAND} #{path} #{remote_dest}"
          end
        end

        private
        attr_reader :local_paths
        attr_reader :remote_dest
      end
    end
  end
end
