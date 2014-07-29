require 'spec_helper'

describe Rubotium::Devices do
  let(:devices_class) {described_class}

  before do
    Rubotium::Device.stub(:new).and_return("Device_Instance")
  end

  context 'given device' do
    let(:devices) {devices_class.new('emulator')}

    it 'should complain about device being not accessible' do
      Rubotium::Adb::Devices.any_instance.stub(:list).and_return([])
      expect { devices.all }.to raise_error(Rubotium::NoDevicesError)
    end

    it 'should complain about not matched devices' do
      Rubotium::Adb::Devices.any_instance.stub(:list).and_return(['nexus'])
      expect { devices.all }.to raise_error(Rubotium::NoMatchedDevicesError)
    end

    it 'should return test runner per device' do
      Rubotium::Adb::Devices.any_instance.stub(:list).and_return(['emulator'])
      devices.all.should == [ "Device_Instance" ]
    end

    it 'should match devices' do
      Rubotium::Adb::Devices.any_instance.stub(:list).and_return(['emulator', 'amolator', 'nexus', 'emulatores111', '113242'])
      devices.send(:matched_devices, 'emulator').should == ["emulator", "emulatores111"]
    end

  end

  context 'without device' do
    let(:devices) { devices_class.new }

    it 'should use all available devices' do
      Rubotium::Adb::Devices.any_instance.stub(:list).and_return(['emulator', 'amolator', 'nexus', 'emulatores111', '113242'])
      devices.all.should == ["Device_Instance", "Device_Instance", "Device_Instance", "Device_Instance", "Device_Instance"]
    end

  end

end