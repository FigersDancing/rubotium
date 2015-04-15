module Rubotium
  class CmdResult
    attr_reader :status_code, :result

    def initialize(status_code, result)
      @status_code = status_code
      @result = result
    end
  end
end
