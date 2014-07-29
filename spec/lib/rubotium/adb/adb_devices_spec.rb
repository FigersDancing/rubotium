require 'spec_helper'

describe Rubotium::Adb::Devices do
  let(:devices)  { described_class.new }

  it 'should return list of devices' do
    Rubotium::CMD.stub(:run_command).and_return(Fixtures::Adb::Devices.two_devices_attached)
    devices.list.should == ['emulator-5554', 'emulator-5556']
  end

  it 'should not return offline devices' do
    Rubotium::CMD.stub(:run_command).and_return(Fixtures::Adb::Devices.two_devices_attached_one_is_offline)
    devices.list.should == ['emulator-5556']
  end

  it 'should return one device' do
    Rubotium::CMD.stub(:run_command).and_return(Fixtures::Adb::Devices.one_device)
    devices.list.should == ['emulator-5554']
  end

  it 'should return zero devices if none are attached' do
    Rubotium::CMD.stub(:run_command).and_return(Fixtures::Adb::Devices.one_device_offline)
    devices.list.should == []
  end
end