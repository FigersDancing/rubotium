module Rubotium
  class TestCasesReader
    def initialize(device, test_package, options = {})
      @device         = device
      @test_package   = test_package
      @annotations    = options.delete(:annotation)
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

    attr_reader :device, :test_package

    def instrument_command
      "am instrument -w -r -e log true #{test_package.name}/#{test_package.test_runner}"
    end


  end
end
