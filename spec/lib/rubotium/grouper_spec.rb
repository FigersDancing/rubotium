require 'spec_helper'

describe Rubotium::Grouper do
  let(:grouper) { described_class }

  it 'should create two equal groups' do
    tests = {
      :a => [1,2,3,4,5], :b => [6,7,8,9,10]
    }
    result = [{:a=>[1, 3, 5], :b=>[7, 9]}, {:a=>[2, 4], :b=>[6, 8, 10]}]

    grouper.new(tests).create_groups(2).should == result
  end

  it 'should create three equal groups' do
    tests = {
      :a => [1,2,3,4,5], :b => [6,7,8,9,10]
    }

    result = [{:a=>[1, 4], :b=>[7, 10]}, {:a=>[2, 5], :b=>[8]}, {:a=>[3], :b=>[6, 9]}]
    grouper.new(tests).create_groups(3).should == result
  end
end