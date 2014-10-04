module Rubotium
  module Adb
    module Commands
      class InstallCommand
        COMMAND = 'install'
        def initialize(apk_path)
          @apk_path = apk_path
        end

        def executable_command
          "#{COMMAND} #{apk_path}"
        end

        private
        attr_reader :apk_path
      end
    end
  end
end
