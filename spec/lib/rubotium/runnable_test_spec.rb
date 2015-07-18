require 'spec_helper'

describe Rubotium::RunnableTest do
  let(:test1) {Rubotium::RunnableTest.new("PackageName", "testName")}

  context 'when two instances have the same name' do
    let(:test2) {Rubotium::RunnableTest.new("PackageName", "testName")}

    it 'eql? should return equal' do
      (test1.eql? test2).should be true
    end

    it '== should return equal' do
      (test1 == test2).should be true
    end
  end

  context 'when two instances have different names' do
    let(:test2) {Rubotium::RunnableTest.new("PackageNameOther", "testNameOther")}

    it 'eql? should return false' do
      (test1.eql? test2).should be false
    end

    it '== should return equal' do
      (test1 == test2).should be false
    end
  end
end
