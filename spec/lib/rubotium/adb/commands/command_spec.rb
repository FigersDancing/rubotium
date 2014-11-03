require 'spec_helper'

describe Rubotium::Adb::Commands::Command do
  let(:subject) { described_class.new(serial) }
  let(:adb_command) { 'the command' }
  let(:result) { 'result' }
  let(:command_to_run) { double(Object) }

  before do
    expect(Rubotium::CMD).to receive(:run_command).with(shell_command) { result }
    expect(command_to_run).to receive(:executable_command).at_least(:once) { adb_command }
  end

  context 'when nil serial is defined' do
    let(:serial) { nil }
    let(:shell_command) { "adb #{adb_command}" }

    it 'executes the command without a serial' do
      expect(subject.execute(command_to_run)).to eq result
    end
  end

  context 'when "" serial is defined' do
    let(:serial) { '' }
    let(:shell_command) { "adb #{adb_command}" }

    it 'executes the command without a serial' do
      expect(subject.execute(command_to_run)).to eq result
    end
  end

  context 'when a real serial is defined' do
    let(:serial) { '01234567' }
    let(:shell_command) { "adb -s #{serial} #{adb_command}" }

    it 'executes the command with a serial' do
      expect(subject.execute(command_to_run)).to eq result
    end
  end
end
