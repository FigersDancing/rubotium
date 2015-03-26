require 'spec_helper'

describe Rubotium::Adb::Parsers::TestResultsParser do
  context 'with multiple tests ' do
    let(:parser) { described_class.new(Fixtures::AdbRawResults.multiple_test_results) }

    it 'should return three test results' do
      parser.count.should be 3
    end

    it 'should be successful' do
      expect(parser).to be_successful
    end

    it 'should return time' do
      expect(parser.time).to eql(0.142)
    end

    it 'should not have error message' do
      expect(parser.message).to be_empty
    end
  end

  context 'with single test' do
    let(:parser) { described_class.new(Fixtures::AdbRawResults.single_failed_test) }

    it 'should return three test results' do
      parser.count.should be 1
    end

    it 'should be successful' do
      expect(parser).to be_successful
    end

    it 'should return time' do
      expect(parser.time).to eql(16.79)
    end

    it 'should not have error message' do
      expect(parser.message).to be_empty
    end
  end

  context 'when tests cannot start' do
    let(:parser) { described_class.new(Fixtures::AdbRawResults.test_cannot_start_error) }

    it 'should return 0 test results' do
      parser.count.should be 0
    end

    it 'should be failed' do
      expect(parser).to be_failed
    end

    it 'should return time = 0' do
      expect(parser.time).to eql(0.0)
    end

    it 'should return error message' do
      error_message = "Unable to find instrumentation info for: " +
        "ComponentInfo{com.soundcloud.android.tests/com.soundcloud.android.tests.RandomizingRunnr}"
      expect(parser.message).to eql(error_message)
    end
  end

  context 'when tests throw error' do
    let(:parser) { described_class.new(Fixtures::AdbRawResults.test_run_error) }

    it 'should return 0 test results' do
      parser.count.should be 0
    end

    it 'should be failed' do
      expect(parser).to be_failed
    end

    it 'should return time = 0' do
      expect(parser.time).to eql(0.0)
    end

    it 'should return error message' do
      error_message = "java.lang.RuntimeException\njava.lang.RuntimeException: " +
        "Could not find test class. Class: com.soundcloud.android.MenuCrashTests"
      expect(parser.message).to eql(error_message)
    end
  end

  context 'when application crashes during test execution' do
    let(:parser) { described_class.new(Fixtures::AdbRawResults.app_crashed_during_tests) }

    it 'should return 0 test results' do
      parser.count.should be 0
    end

    it 'should be failed' do
      expect(parser).to be_failed
    end

    it 'should return time = 0' do
      expect(parser.time).to eql(0.0)
    end

    it 'should return error message' do
      error_message = "java.lang.RuntimeException\njava.lang.RuntimeException: developer requested crash"
      expect(parser.message).to eql(error_message)
    end
  end
end
