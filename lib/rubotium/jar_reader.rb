require 'set'
module Rubotium
  class JarReader
    TEST_PATTERN = Regexp.new('public void (test.*)\(')
    attr_reader :path_to_jar

    def initialize(jar_path)
      @path_to_jar = jar_path
    end

    def test_suites
      Converter.new(classes_in_jar).convert
    end

    def get_tests
      parse
    end

    private
    def classes_in_jar
      CMD.run_command("jar -tf #{path_to_jar} | grep '.class'")
    end

    def tests_in_class(suite_name)
      CMD.run_command "javap -classpath #{path_to_jar} #{suite_name}"
    end

    def parse
      Parallel.map(test_suites, :in_threads=> test_suites.count) {|test_suite|
        tests_in_class(test_suite.name).scan(TEST_PATTERN).flatten.each{|test|
          test_suite.add_test_case(TestCase.new(test))
        }
        test_suite
      }.delete_if{|test_suite| test_suite.test_cases.empty?}
    end


    class Converter
      attr_reader :list
      def initialize(list_of_classes)
        @list = list_of_classes.split
      end

      def convert
        deduplicated_test_suites
      end

      private
      def test_suites
        converted_class_names.map{|class_name|
          TestSuite.new(class_name)
        }
      end

      def converted_class_names
        list.map{|class_name|
          class_name.gsub("/", ".")
            .gsub(".class", "")
            .gsub(/\$.*/, "")
        }
      end

      def deduplicated_test_suites
        test_suites.uniq{|test_suite|
          test_suite.name
        }
      end
    end
  end
end
