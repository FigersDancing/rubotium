require 'spec_helper'

describe Rubotium::TestsRunner do
  let(:device1) { double('Device1') }
  let(:device2) { double('Device2') }
  let(:devices) { [device1, device2] }
  let(:tests) { (0..10).to_a.map{|elem| RunnableTest.new("package#{elem}", "name#{elem}")} }
  let(:test_runner) { double(Rubotium::TestRunners::InstrumentationTestRunner) }
  let(:test_package) { double(Rubotium::Package) }

  before do
    device1.stub(:name).and_return('device1')
    device2.stub(:name).and_return('device2')
    test_package.stub(:test_runner).and_return('com.android.TestRunner')
    test_package.stub(:name).and_return('com.android.test#testToRun')
  end
  context 'without extra options' do
    let(:runner) { described_class.new(devices, tests, test_package) }

    context 'when running tests' do
      before do
        device1.stub(:shell)
        device2.stub(:shell)
      end

      it 'runs all the tests from the queue' do
        runner.run_tests
        expect(runner.send :tests_queue).to be_empty
      end

      it 'executes tests on all devices' do
        expect(device1).to receive(:shell).exactly(1).times.and_return { sleep 1 }
        expect(device2).to receive(:shell).exactly(10).times
        runner.run_tests
      end

      it 'knows how many tests it has' do
        runner.tests_count.should eql(11)
      end
    end
  end
end
