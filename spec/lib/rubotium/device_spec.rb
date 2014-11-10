require 'spec_helper'

shared_examples 'a Rubotium::Device' do
  it 'installs package on device' do
    path_to_apk = 'path/to/apk'
    expect(command).to receive(:install).with(path_to_apk)
    device.install(path_to_apk)
  end

  it 'uninstalls package from device' do
    package_name = 'com.package.name'
    expect(command).to receive(:uninstall).with(package_name)
    device.uninstall(package_name)
  end

  it 'pulls files from device' do
    files_to_pull = '/sdcard/files/'
    expect(command).to receive(:pull).with(files_to_pull)
    device.pull(files_to_pull)
  end

  it "knows it's name" do
    expect(command).to receive(:shell).with("getprop ro.product.model").and_return('MyNameIs')
    expect(device.name).to eql('MyNameIs')
  end

  it 'executes shell commands' do
    getprop = 'getprop ro.product.model'
    expect(command).to receive(:shell).with(getprop)
    device.shell(getprop)
  end
end

describe Rubotium::Device do
  let(:device)  { described_class.new(serial) }
  let(:command) { double(Rubotium::Adb::Commands::Command)}

  before do
    device.stub(:adb_command).and_return(command)
  end

  context 'when a serial is provided' do
    let(:serial) { '12345' }

    it_behaves_like 'a Rubotium::Device'
  end

  context 'when no serial is provided' do
    let(:serial) { nil }

    it_behaves_like 'a Rubotium::Device'
  end
end
