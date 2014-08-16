class RunableTest
  def initialize(package_name, test_name)
    @package_name = package_name
    @test_name    = test_name
  end

  def name
    "#{package_name}##{test_name}"
  end
  private
  attr_reader :package_name, :test_name
end