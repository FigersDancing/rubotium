require 'spec_helper'

describe Rubotium::Adb::Instrumentation do
  let (:instr) { described_class }

  context 'running tests' do
    let (:inst) { instr.new(" ") }
    it 'should raise error if test runner name is not set' do
      inst.test_package_name = "test_package"
      expect { inst.run_test("test", "test") }.to raise_error (Rubotium::Adb::NoTestRunnerError)
    end

    it 'should raise error if test package name is not set' do
      inst.test_runner = "runner"
      expect { inst.run_test("test", "test") }.to raise_error (Rubotium::Adb::NoTestPackageError)
    end

    it 'runs correct test' do
      inst.test_package_name = "package_name"
      inst.test_runner = "TestRunner"

      command = "am instrument -w -e class package#test package_name/TestRunner"
      Rubotium::Adb::Shell.any_instance.should_receive(:run_command).with(command)
      Rubotium::Adb::Shell.any_instance.stub(:run_command).and_return(Fixtures::Adb.test_success)
      inst.run_test("package", "test")

    end

  end
end