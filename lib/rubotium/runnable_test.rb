module Rubotium
  class RunnableTest
    attr_reader :package_name, :test_name
    def initialize(package_name, test_name)
      @package_name = package_name
      @test_name    = test_name
    end

    def name
      "#{package_name}##{test_name}"
    end

    def ==(other)
      other.instance_of?(self.class) && name == other.name
    end

    def eql?(other)
      other.instance_of?(self.class) && name == other.name
    end
  end
end
