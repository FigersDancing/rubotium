require 'spec_helper'

# encoding: utf-8
require "pp"

describe Rubotium::Apk::AndroidApk do
  let(:aapt) {double(Rubotium::Apk::Aapt)}

  sample_file_path = File.dirname(__FILE__) + "/mock/sample.apk"
  sample2_file_path = File.dirname(__FILE__) + "/mock/BarcodeScanner4.2.apk"
  icon_not_set_file_path = File.dirname(__FILE__) + "/mock/UECExpress.apk"
  dummy_file_path = File.dirname(__FILE__) + "/mock/dummy.apk"


  context 'with non existing apk' do
    let(:apk) { described_class.new(aapt, 'dummy.apk') }

    it "should raise exception" do
      expect{apk}.to raise_exception(Errno::ENOENT)
    end
  end

  context 'with not readable apk' do
    let(:apk) { described_class.new(aapt, dummy_file_path) }

    it 'should raise exception' do
      expect(aapt).to receive(:dump).and_return Rubotium::CmdResult.new(1, "W/zipro   (77199): Error opening archive spec/lib/rubotium/apk/mock/dummy.apk: Invalid file
ERROR: dump failed because assets could not be loaded")
      expect{apk.package_name}.to raise_error(RuntimeError)
    end
  end

  context 'with valid apk file' do
    let(:apk) { described_class.new(aapt, sample_file_path) }

      it 'should read package_name' do
        expect(aapt).to receive(:dump).and_return Rubotium::CmdResult.new(0, "package: name='com.example.sample' versionCode='1' versionName='1.0' platformBuildVersionName=''
sdkVersion:'7'
targetSdkVersion:'15'
application-label:'sample'
application-label-ja:'g'
application-icon-160:'res/drawable-mdpi/ic_launcher.png'
application-icon-240:'res/drawable-hdpi/ic_launcher.png'
application-icon-320:'res/drawable-xhdpi/ic_launcher.png'
application: label='sample' icon='res/drawable-mdpi/ic_launcher.png'
application-debuggable
feature-group: label=''
  uses-feature: name='android.hardware.touchscreen'
  uses-implied-feature: name='android.hardware.touchscreen' reason='default feature for all apps'
supports-screens: 'small' 'normal' 'large' 'xlarge'
supports-any-density: 'true'
locales: '--_--' 'ja'
densities: '160' '240' '320'")
        expect(apk.package_name).to eql 'com.example.sample'
      end

  end
end
