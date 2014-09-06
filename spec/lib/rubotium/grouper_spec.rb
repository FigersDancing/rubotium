require 'spec_helper'

describe Rubotium::Grouper do
  let(:grouper)   { described_class }
  let(:testsuite1) {TestSuite.new('test_package1')}
  let(:testsuite2) {TestSuite.new('test_package2')}

  before do
    RunnableTest.should_receive(:new){|arg1, arg2|
      "#{arg1}, #{arg2}"
    }.at_least(:once)
  end

  def add_test_cases_to_testsuite(testsuite, test_case_names)
    test_case_names.each{|name|
      testsuite.add_test_case(TestCase.new(name))
    }
  end

  it 'should create two equal groups' do
    add_test_cases_to_testsuite(testsuite1, ['name1', 'name2', 'name3', 'name4'])
    tests = [ testsuite1 ]

    result =  [
                ["test_package1, name1", "test_package1, name3"],
                ["test_package1, name2", "test_package1, name4"]
    ]

    grouper.new(tests, 2).create_groups.should == result
  end

  it 'should create three equal groups' do
    add_test_cases_to_testsuite(testsuite1, ['name1', 'name2', 'name4'])
    add_test_cases_to_testsuite(testsuite2, ['name3'])
    tests = [ testsuite1, testsuite2 ]

    result =  [
                ["test_package1, name1", "test_package2, name3"],
                ["test_package1, name2"],
                ["test_package1, name4"]
    ]

    grouper.new(tests, 3).create_groups.should == result
  end

  it 'should create one group' do
    add_test_cases_to_testsuite(testsuite1, ['name1', 'name2', 'name3', 'name4'])
    tests = [ testsuite1 ]

    grouper.new(tests, 1).create_groups.should have(1).items
    grouper.new(tests, 1).create_groups.should == [
      ["test_package1, name1", "test_package1, name2", "test_package1, name3", "test_package1, name4"]
    ]

  end
end