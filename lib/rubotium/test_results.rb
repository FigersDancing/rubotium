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

    def group_by_failures
      TestSuites.new(
      group_by_package.map{|name, test_results|
        TestSuite.new(name, test_results)
      })
    end

    attr_reader :results
  end

  class TestSuites
    def initialize(test_suites)
      @test_suites = test_suites
    end

    def time
      test_suites.map(&:time).inject(&:+).to_s
    end

    def each
      test_suites.each{|suite|
        yield(suite)
      }
    end

    def total
      sum_of(:tests_count)
    end

    def passed
      sum_of(:passed_count)

    end

    def errored
      sum_of(:error_count)
    end

    def failed
      sum_of(:failures_count)
    end

    private
    attr_reader :test_suites

    def sum_of(value)
      select_suites_with(value).inject(&:+)
    end

    def select_suites_with(value)
      test_suites.map(&value).compact
    end
  end

  class TestSuite
    attr_reader :name

    def initialize(name, test_cases)
      @name = name
      @test_cases = test_cases
    end

    def failures_count
      @failures ||= count_by(:failed?).to_i
    end

    def error_count
      @errors ||= count_by(:errored?).to_i
    end

    def passed_count
      @passed_count ||= count_by(:passed?).to_i
    end

    def state
      return (failures_count + error_count > 0) ? 'failed' : 'passed'
    end

    def time
      @time ||= sum_of(:time)
    end

    def tests_count
      @tests_count ||= test_cases.count
    end

    def each_test
      test_cases.each{|test_case|
        yield(test_case)
      }
    end

    private
    attr_reader :test_cases

    def count_by(value)
      test_cases
      .select(&value)
      .count
    end

    def sum_of(value_to_sum)
      test_cases
        .map(&value_to_sum)
        .inject(&:+)
    end
  end
end
