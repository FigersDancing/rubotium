require 'set'
module Rubotium
  class JarReader
    TEST_PATTERN = Regexp.new('public void (test.*)\(')
    attr_reader :path_to_jar

    def initialize(jar_path)
      @path_to_jar = jar_path
    end

    def get_classes
      result = CMD.run_command("jar -tf #{path_to_jar} | grep '.class'")
      Converter.new(result).convert
    end

    def get_tests
      get_classes.inject({}){|hash, class_name|
        contents = CMD.run_command "javap -classpath #{@path_to_jar} #{class_name}"
        hash[class_name] = contents.scan(TEST_PATTERN).flatten
        hash
      }.delete_if {|_, value| value.empty? }
    end

    private
    class Converter
      attr_reader :list, :deduplicated_classes
      def initialize(list_of_classes)
        @list = list_of_classes.split
        @deduplicated_classes = Set.new
      end

      def convert
        convert_class_names
        deduplicate
        deduplicated_classes.to_a
      end

      def convert_class_names
        list.each{|class_name|
          class_name.gsub!("/", ".")
          class_name.gsub!(".class", "")
          class_name.gsub!(/\$.*/, "")
        }
      end

      def deduplicate
        list.each{|class_name|
          @deduplicated_classes.add class_name
        }
      end

    end
  end
end
