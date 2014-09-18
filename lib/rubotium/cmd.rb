require 'timeout'
module Rubotium
  class CMD
    class << self
      def run_command(command_to_run, opts = {})
        begin
          Timeout::timeout(opts[:timeout] || 10 * 60) {
            Rubotium.logger.debug "[EXECUTING]: #{command_to_run}"
            `#{command_to_run}`
          }
        rescue Timeout::Error
          ""
        end
      end
    end
  end
end
