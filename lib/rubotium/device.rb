module Rubotium
  class Device
    attr_accessor :testsuite, :test_queue
    attr_reader   :serial, :results
    def initialize(serial, test_runner)
      @adb_shell  = Rubotium::Adb::Shell.new(serial)
      @runner     = test_runner
      @retry      = 1
      @serial     = serial
      @results    = {}
      @command    = Rubotium::Adb::Command.new(serial)
    end

    def test_runner_name= name
      runner.test_runner = name
    end

    def name
      shell('getprop ro.product.model')
    end

    def test_package_name= name
      runner.test_package_name = name
    end

    def install(apk_path)
      command.execute(Rubotium::Adb::InstallCommand.new(apk_path))
    end

    def uninstall(package_name)
      command.execute(Rubotium::Adb::UninstallCommand.new(package_name))
    end

    def pull(path)
      command.execute(Rubotium::Adb::PullCommand.new(path))
    end

    def shell(command)
      adb_shell.run_command(command)
    end

    def run_tests
      raise(NoTestSuiteError, "Please setup test suite before running tests") if test_queue.nil?
      until(test_queue.empty?)
        runnable_test = test_queue.pop
        @results[runnable_test.package_name] = [] if(@results[runnable_test.package_name].nil?)
        puts runnable_test.name
        run_count = 0
        puts "TEST: #{runnable_test.name}"
        while ((result = runner.run_test(runnable_test)) && (result.failed? || result.errored?) && run_count < @retry ) do
          puts "RERUNNING TEST: #{runnable_test.name}, STATUS: #{result.status}"
          run_count += 1
        end
        puts "FINISHED with status: #{result.status}"
        @results[runnable_test.package_name].push(result)
      end
    end

    private
    attr_reader :runner, :command, :adb_shell
  end
end