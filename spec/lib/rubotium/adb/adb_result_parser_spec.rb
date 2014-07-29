require 'spec_helper'

describe Rubotium::Adb::TestResultParser do
  let(:parser) { described_class }

  context 'failed test' do
    let(:parsed_result) { parser.new(Fixtures::Adb.test_failure, "", "") }

    it 'should not be passed' do
      parsed_result.should_not be_passed
    end

    it 'should be failed' do
      parsed_result.should be_failed
    end

    it 'should not be errored' do
      parsed_result.should_not be_errored
    end

    it 'should get the stack trace' do
      parsed_result.stack_trace.should == Fixtures::Adb.test_failure_stack_trace
    end

    it "should get test's duration time" do
      parsed_result.time.should be_eql 6.485
    end

    it 'should not have error message' do
      parsed_result.error_message.should be_empty
    end
  end

  context 'passed test' do
    let(:parsed_result) { parser.new(Fixtures::Adb.test_success, "", "") }

    it 'should be passed' do
      parsed_result.should be_passed
    end

    it 'should not be failed' do
      parsed_result.should_not be_failed
    end

    it 'should not be errored' do
      parsed_result.should_not be_errored
    end

    it 'should not have a stack trace' do
      parsed_result.stack_trace.should be_empty
    end

    it "should get test's duration" do
      parsed_result.time.should be_eql 5.873
    end

    it 'should not have error message' do
      parsed_result.error_message.should be_empty
    end
  end

  context 'error in test' do
    let(:parsed_result) { parser.new(Fixtures::Adb.test_error, "", "") }

    it 'should not be passed' do
      parsed_result.should_not be_passed
    end

    it 'should be failed' do
      parsed_result.should be_failed
    end

    it 'should not be errored' do
      parsed_result.should_not be_errored
    end

    it 'should get the stack trace' do
      parsed_result.stack_trace.should == Fixtures::Adb.test_error_stack_trace
    end

    it "should get test's duration time" do
      parsed_result.time.should be_eql 4.314
    end

    it 'should not have error message' do
      parsed_result.error_message.should be_empty
    end
  end

  context 'run error' do
    let(:parsed_result) { parser.new(Fixtures::Adb.test_run_error, "", "") }

    it 'should not be passed' do
      parsed_result.should_not be_passed
    end

    it 'should not be failed' do
      parsed_result.should_not be_failed
    end

    it 'should be errored' do
      parsed_result.should be_errored
    end

    it 'should not take time to execute' do
      parsed_result.time.should be_eql 0
    end

    it 'should know the error reason' do
      parsed_result.error_message.should be_eql Fixtures::Adb.error_message
    end

    it 'should not have a stack trace' do
      parsed_result.stack_trace.should be_empty
    end
  end
  context 'passed tests with negative time' do
    let(:parsed_result) { parser.new(Fixtures::Adb.passed_negative_time, "", "") }

    it 'should not be passed' do
      parsed_result.time.should == 53.656
    end
  end
end