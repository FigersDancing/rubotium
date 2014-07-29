require 'spec_helper'

describe Rubotium::Adb::Shell do
  let(:shell)   { described_class }
  before { Rubotium::CMD.stub(:run_command) }

  context 'with no device given' do
    it 'should execute commands without device' do
      shell.new(nil).send(:command).should == "adb shell"
    end

    it 'should execute commands if device string is empty' do
      shell.new("").send(:command).should == "adb shell"
    end
  end

  context 'with given device' do
    it 'should execute commands on a device' do
      shell.new("12345").send(:command).should == "adb -s 12345 shell"
    end
  end

end
