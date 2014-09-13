require 'spec_helper'

describe Rubotium::Adb::Parsers::Procrank do
  context 'when process has not started' do
    let(:parser) { described_class.new('')}

    it 'returns zero value PID' do
      parser.parse.pid.should eql(0)
    end

    it 'returns zero value Vss' do
      parser.parse.vss.should eql(0)
    end

    it 'returns zero value Rss' do
      parser.parse.rss.should eql(0)
    end

    it 'returns zero value Pss' do
      parser.parse.pss.should eql(0)
    end

    it 'returns zero value Uss' do
      parser.parse.uss.should eql(0)
    end

    it 'returns empty cmdline' do
      parser.parse.cmdline.should be_empty
    end

  end

  context 'with process using memory' do
    let(:parser) { described_class.new('  814   20404K   20328K    3030K    2168K  com.android.dialer')}

    it 'returns PID' do
      parser.parse.pid.should eql(814)
    end

    it 'returns Vss' do
      parser.parse.vss.should eql(20404)
    end

    it 'returns Rss' do
      parser.parse.rss.should eql(20328)
    end

    it 'returns Pss' do
      parser.parse.pss.should eql(3030)
    end

    it 'returns Uss' do
      parser.parse.uss.should eql(2168)
    end

    it 'returns cmdline' do
      parser.parse.cmdline.should eql('com.android.dialer')
    end

  end
end
