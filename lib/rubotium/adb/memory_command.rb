module Rubotium
  module Adb
    class MemoryCommand
      COMMAND = 'procrank'
      def initialize(application_package_name)
        @application_package_name = application_package_name
      end

      def executable_command
        "#{COMMAND} | grep #{application_package_name}"
      end

      private
      attr_reader :application_package_name
    end
  end
end
