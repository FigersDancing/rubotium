require 'spec_helper'

# encoding: utf-8
require "pp"

describe Rubotium::Apk::AndroidApk do

  sample_file_path = File.dirname(__FILE__) + "/mock/sample.apk"
  sample2_file_path = File.dirname(__FILE__) + "/mock/BarcodeScanner4.2.apk"
  icon_not_set_file_path = File.dirname(__FILE__) + "/mock/UECExpress.apk"
  dummy_file_path = File.dirname(__FILE__) + "/mock/dummy.apk"

  context 'with non existing apk' do
    let(:apk) { described_class.new('dummy.apk') }

    it "should raise exception" do
      expect{apk}.to raise_exception(Errno::ENOENT)
    end
  end

  context 'with not readable apk' do
    let(:apk) { described_class.new(dummy_file_path) }

    it 'should raise exception' do
      expect{apk.package_name}.to raise_error(RuntimeError)
    end
  end

  context 'with valid apk file' do
    let(:apk) { described_class.new(sample_file_path) }

      it 'should read package_name' do
        expect(apk.package_name).to eql 'com.example.sample'
      end

  end
end
