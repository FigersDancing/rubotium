require 'spec_helper'
require 'ostruct'

describe Rubotium::TestRunners::InstrumentationTestRunner do
  let(:test_package)  { double(Rubotium::Package) }
  let(:device)        { double(Rubotium::Device) }
  let(:runnable_test) { double(Rubotium::RunnableTest) }
  let(:log_writter)   { double(Rubotium::LogWritter) }

  let(:runner) {described_class.new(device, test_package, {}, log_writter)}

  context 'when running test times out' do
    before { expect(device).to receive(:shell).and_return(OpenStruct.new(:status_code => 1)) }

    it 'fails the test' do
      expect(test_package).to receive(:name).and_return('Package name')
      expect(test_package).to receive(:test_runner).and_return('test runner')
      expect(runnable_test).to receive(:test_name).and_return('Test name')
      expect(runnable_test).to receive(:name).and_return('name').exactly(2).times
      expect(runnable_test).to receive(:package_name).and_return('testPackage name')
      expect(device).to receive(:clean_logcat)
      expect(device).to receive(:logcat)
      expect(log_writter).to receive(:save_to_file)

      runner.run_test(runnable_test)
    end

  end
end
