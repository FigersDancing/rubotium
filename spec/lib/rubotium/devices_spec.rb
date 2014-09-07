require 'spec_helper'
require 'ostruct'

describe Rubotium::Devices do
  let(:devices_class) {described_class}
  let(:device) {OpenStruct.new(:name=>"TestDevice")}

  before do
    Rubotium::Device.stub(:new).and_return(device)
  end

  context 'with matched device' do
    let(:devices) {devices_class.new(:name=>'TestDevice')}
    before do
      Rubotium::Adb::Devices.any_instance.stub(:attached).and_return([device])
    end

    it 'should return matched devices' do
      devices.all.should == [ device ]
    end

  end

  context 'with no devices attached devices' do
    let(:devices) { devices_class.new(:name=>'Nexus') }

    it 'should complain about device being not accessible' do
      Rubotium::Adb::Devices.any_instance.stub(:attached).and_return([])
      expect { devices.all }.to raise_error(Rubotium::NoDevicesError)
    end
  end
  context 'with no matched' do
    let(:devices) {devices_class.new(:name=>'Nexus')}

    it 'should complain about not matched devices' do
      Rubotium::Adb::Devices.any_instance.stub(:attached).and_return([device])
      expect { devices.all }.to raise_error(Rubotium::NoMatchedDevicesError)
    end
  end

  context 'without device matcher' do
    let(:devices) { devices_class.new }

    it 'should use all available devices' do
      devices.all.should == [device]
    end

  end

end