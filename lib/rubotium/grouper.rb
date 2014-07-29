module Rubotium
  class Grouper
    def initialize(test_suites)
      @test_suites = test_suites
    end

    def create_groups(num_of_groups)
      groups = Array.new(num_of_groups) { Hash.new {|hash, key| hash[key] = []} }

      enum = groups.cycle
      test_suites.each{|test_suite, tests|
        tests.each{|test|
          group = enum.next
          group[test_suite].push(test)
        }
      }
      groups
    end

    private
    attr_reader :test_suites

  end
end
