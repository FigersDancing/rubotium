module Rubotium
  class Grouper
    def initialize(test_suites, num_of_groups)
      @test_suites   = test_suites
      @num_of_groups = num_of_groups
    end

    def create_groups
      runnable_tests.each{|runnable|
        next_bucket.push(runnable)
      }
      buckets
    end

    def runnable_tests
      test_suites.map {|test_suite|
        test_suite.test_cases.map{|test|
          RunnableTest.new(test_suite.name, test.name)
        }
      }.flatten
    end

    def next_bucket
      buckets_enum.next
    end

    def buckets_enum
      @buckets_enum ||= buckets.cycle
    end


    def buckets
      @buckets ||= Array.new(num_of_groups) { [] }
    end

    private
    attr_reader :test_suites, :num_of_groups

  end
end
