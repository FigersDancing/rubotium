module Rubotium
  class TestResults
    def initialize(results)
      @results = results
    end

    def group_by_package
      json = {}
      results.each{|result|
        json[result.package_name] = [] unless json[result.package_name]
        json[result.package_name].push(result)
      }
      json
    end

    attr_reader :results
  end
end
