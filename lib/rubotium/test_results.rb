module Rubotium
  class TestResults
    def initialize(results)
      @results = results
    end

    def group_by_package
      json = {}
      results.each{|result|
        json[result.class_name] = [] unless json[result.class_name]
        json[result.class_name].push(result)
      }
      json
    end

    attr_reader :results
  end
end
