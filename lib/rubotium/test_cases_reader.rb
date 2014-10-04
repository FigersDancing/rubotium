module Rubotium
  class TestCasesReader
    def initialize(device, test_package, options = {})
      @device         = device
      @test_package   = test_package
      @annotation     = options.delete(:annotation)
    end

    def read_tests
      result = device.shell(instrument_command)
      Rubotium::Adb::Parsers::TestResultsParser.new(result).test_results.map{|test|
        create_runnable_test(test)
      }
    end

    def create_runnable_test(test)
      Rubotium::RunnableTest.new(test.class_name, test.test_name)
    end

    private

    attr_reader :device, :test_package, :annotation

    def instrument_command
      "am instrument -w -r -e log true #{with_annotation} #{test_package.name}/#{test_package.test_runner}"
    end

    def with_annotation
      annotation ? "-e annotation #{annotation}" : ''
    end
  end
end
