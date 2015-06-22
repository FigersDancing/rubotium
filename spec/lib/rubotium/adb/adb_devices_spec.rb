require 'spec_helper'

describe Rubotium::Adb::Devices do
  let(:devices)  { described_class.new }

  before do
    devices.stub(:create_device) {|serial|
      OpenStruct.new(:name => serial)
    }
  end

  context 'when one device is attached' do
    before do
      Rubotium::CMD.stub(:run_command).and_return(Fixtures::Adb::Devices.one_device_attached)
    end

    it 'should return one device' do
      devices.attached.count == 1
    end
  end

  context 'when two devices are attached' do
    before do
      Rubotium::CMD.stub(:run_command).and_return(Fixtures::Adb::Devices.two_devices_attached)
    end
    it 'should return list of devices' do
      devices.attached.count.should == 2
    end

    it 'should return two different devices' do
      devices.attached.first.should_not eql(devices.attached.last)
    end
  end

  context 'when two devices are attached and one is offline' do
    before do
      Rubotium::CMD.stub(:run_command).and_return(Fixtures::Adb::Devices.two_devices_attached_one_is_offline)
    end
    it 'should not return offline devices' do
      devices.attached.count.should == 1
    end

    it 'should return attached device' do
      devices.attached.first.name.should eql('emulator-5556')
    end
  end

  context 'when one device is attached and offline' do
    before do
      Rubotium::CMD.stub(:run_command).and_return(Fixtures::Adb::Devices.one_device_attached_and_offline)
    end
    it 'should return zero devices if none are online' do
      devices.attached.should == []
    end
  end

  context 'when no devices are attached' do
    it 'should run adb_devices_command 10 times' do
      devices.should_receive(:adb_devices_command).exactly(10).times
          .and_return(Fixtures::Adb::Devices.no_devices_attached.result)
      devices.attached
    end

    it 'should return zero devices if none are attached' do
      Rubotium::CMD.stub(:run_command).and_return(Fixtures::Adb::Devices.no_devices_attached)
      devices.attached.should == []
    end
  end
end
