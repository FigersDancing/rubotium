module Rubotium
  class TestRunner
    def initialize(devices, tests_package, test_runner, options = {})
      @devices        = devices
      @tests_package  = tests_package
      @tests_runner   = test_runner
      @options        = options
    end

    def run_tests(tests_queue)
      devices.each{|device|
        device.shell()
      }
    end


  end
end