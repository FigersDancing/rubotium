require 'spec_helper'
require 'ostruct'

describe Rubotium::Devices do
  let(:adb_devices) { double(Rubotium::Adb::Devices) }
  let(:device) { OpenStruct.new(:name => "TestDevice", :serial => '1234') }

  before do
    Rubotium::Device.stub(:new).and_return(device)
  end

  context 'when attached device' do
    before do
      expect(adb_devices).to receive(:attached).and_return([device])
      expect(devices).to receive(:adb_devices).and_return(adb_devices)
    end

    context 'is matched' do
      let(:devices) { described_class.new(:name => 'TestDevice') }

      it 'should return matched devices' do
        devices.all.should == [device]
      end
    end

    context 'is not matched' do
      let(:devices) { described_class.new(:name => 'Nexus') }

      it 'should raise exception about not matched devices' do
        expect { devices.all }.to raise_error(Rubotium::NoMatchedDevicesError)
      end
    end

    context 'without given matcher' do
      let(:devices) { described_class.new }

      it 'should return all available devices' do
        devices.all.should == [device]
      end
    end

    context 'with given serial' do
      let(:devices) { described_class.new(:serial => '1234') }

      it 'should return matched device' do
        devices.all.should == [device]
      end
    end
  end

  context 'with no devices attached' do
    let(:devices) { described_class.new(:name => 'Nexus') }

    before do
      Rubotium::Adb::Devices.any_instance.stub(:attached).and_return([])
    end

    it 'should raise exception about device being not connected' do
      expect { devices.all }.to raise_error(Rubotium::NoDevicesError)
    end
  end
end
