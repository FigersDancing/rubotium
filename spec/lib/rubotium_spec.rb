require 'spec_helper'

describe Rubotium do
  let(:rubotium) { described_class }
  before do
    Rubotium::CMD.stub(:run_command).and_return ""
  end

  it 'validates that the application apk exists' do
    expect{rubotium.new({})}.to raise_error(RuntimeError, "Empty configuration")
  end

end
