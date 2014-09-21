require 'spec_helper'

describe Rubotium::Adb::Parsers::SingleTestResultParser do
  context 'with successful test' do
    let(:parser) { described_class.new(Fixtures::AdbRawResult.successful_test_result) }

    it 'should return test name' do
      expect(parser.test_name).to eql('testMenuCrash')
    end

    it 'should return class name' do
      expect(parser.class_name).to eql('com.soundcloud.android.MenuCrashTest')
    end

    it 'should be passed' do
      parser.should be_passed
    end

    it 'should not be failed' do
      parser.should_not be_failed
    end

    it 'should not be errored' do
      parser.should_not be_errored
    end

    it 'should not have stack trace' do
      parser.stack_trace.should be_empty
    end
  end


  context 'with failed test' do
    let(:parser) { described_class.new(Fixtures::AdbRawResult.single_failed_test_result) }

    it 'should return test name' do
      expect(parser.test_name).to eql('testMenuCrash')
    end

    it 'should return class name' do
      expect(parser.class_name).to eql('com.soundcloud.android.MenuCrashTest')
    end

    it 'should not be passed' do
      parser.should_not be_passed
    end

    it 'should be failed' do
      parser.should be_failed
    end

    it 'should not be errored' do
      parser.should_not be_errored
    end

    it 'should get the stack trace' do
      parser.stack_trace.should == Fixtures::AdbRawResult.single_failed_test_stack_trace
    end
  end

  context 'with errored test' do
    let(:parser) { described_class.new(Fixtures::AdbRawResult.such_error_wow) }

    it 'should return test name' do
      expect(parser.test_name).to eql('testMenuCrash')
    end

    it 'should return class name' do
      expect(parser.class_name).to eql('com.soundcloud.android.MenuCrashTest')
    end

    it 'should not be passed' do
      parser.should_not be_passed
    end

    it 'should not be failed' do
      parser.should_not be_failed
    end

    it 'should be errored' do
      parser.should be_errored
    end

    it 'should get the stack trace' do
      expect(parser.stack_trace).to eql(Fixtures::AdbRawResult.such_error_stack_trace)
    end
  end

  context 'with errored test' do
    let(:parser) { described_class.new(Fixtures::AdbRawResult.single_errored_test_result) }

    it 'should return test name' do
      expect(parser.test_name).to eql('testMenuCrash')
    end

    it 'should return class name' do
      expect(parser.class_name).to eql('com.soundcloud.android.MenuCrashTest')
    end

    it 'should not be passed' do
      parser.should_not be_passed
    end

    it 'should not be failed' do
      parser.should_not be_failed
    end

    it 'should not be errored' do
      parser.should be_errored
    end

    it 'should get the stack trace' do
      parser.stack_trace.should == Fixtures::AdbRawResult.single_errored_test_result_stack_trace
    end
  end
end
