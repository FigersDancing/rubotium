module Rubotium
  module Adb
    class UninstallCommand
      COMMAND = 'uninstall'
      def initialize(package_name)
        @package_name = package_name
      end

      def executable_command
        "#{COMMAND} #{package_name}"
      end

      private
      attr_reader :package_name
    end
  end
end