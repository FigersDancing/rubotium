require 'spec_helper'
describe Rubotium::Memory::DataPoint do
  let(:time) { Time.parse("3:00:00") }
  subject(:data_point) {described_class.new(time, "") }

  context 'with procrank results' do
    let(:procrank_results) { OpenStruct.new(
      :pid => 0,
      :vss => 1,
      :rss => 2,
      :pss => 3,
      :uss => 4,
      :cmdline => 'cmdline')
    }

    before do
      parser = double(Rubotium::Adb::Parsers::Procrank)
      expect(parser).to receive(:parse).and_return(procrank_results)
      expect(data_point).to receive(:parser).and_return(parser)
    end

    it 'returns pid' do
      data_point.pid.should eql(0)
    end

    it 'returns vss' do
      data_point.vss.should eql(1)
    end
    it 'returns rss' do
      data_point.rss.should eql(2)
    end
    it 'returns pss' do
      data_point.pss.should eql(3)
    end
    it 'returns uss' do
      data_point.uss.should eql(4)
    end
    it 'returns cmdline' do
      data_point.cmdline.should eql('cmdline')
    end
  end
end
