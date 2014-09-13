require 'spec_helper'

describe Rubotium::Adb::Shell do
  context 'with no device given' do
    let(:shell)   { described_class.new('') }

    it 'should execute commands without device' do
      shell.send(:command).should == "adb shell"
    end

    it 'should execute commands if device string is empty' do
      shell.send(:command).should == "adb shell"
    end
  end

  context 'with given device' do
    let(:shell)   { described_class.new('12345') }
    it 'should execute commands on a device' do
      shell.send(:command).should == "adb -s 12345 shell"
    end

    it 'should execute commands' do
      expect(Rubotium::CMD).to receive(:run_command).with('adb -s 12345 shell foo')
      shell.run_command('foo')
    end
  end

end
