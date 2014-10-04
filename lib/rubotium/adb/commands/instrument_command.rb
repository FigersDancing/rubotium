module Rubotium
  module Adb
    module Commands
      class InstrumentCommand
        COMMAND = 'am instrument -w -e class'
        def initialize(package_name, test_name, test_package_name, test_runner)
          @package_name       = package_name
          @test_name          = test_name
          @test_package_name  = test_package_name
          @test_runner        = test_runner
        end

        def executable_command
          [COMMAND, ].join(' ')
        end

        private

        attr_reader :package_name

        def test_case
          [package_name, test_name].join('#')
        end
      end
    end
  end
end
