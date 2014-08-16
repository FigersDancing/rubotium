class RunableTest
  attr_reader :package_name, :test_name
  def initialize(package_name, test_name)
    @package_name = package_name
    @test_name    = test_name
  end

  def name
    "#{package_name}##{test_name}"
  end
end