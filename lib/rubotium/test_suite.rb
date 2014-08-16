class TestSuite
  attr_reader :name, :test_cases

  def initialize(name)
    @name       = name
    @test_cases = []
  end

  def add_test_case(test_case)
    test_cases.push(test_case)
  end
end