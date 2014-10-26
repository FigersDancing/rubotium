module Rubotium
  module Adb
    module Commands
      class LogcatCommand
        COMMAND = 'logcat'
        def initialize(options)
          @clean = options.delete(:clean) ? '-c' : ''
          @dump  = options.delete(:dump) ? '-d' : ''
        end

        def executable_command
          "#{COMMAND} #{options}"
        end

        private
        attr_reader :clean, :dump

        def options
          [clean, dump].join(' ')
        end
      end
    end
  end
end
