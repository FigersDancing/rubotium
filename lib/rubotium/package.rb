module Rubotium
  class Package
    def initialize(package_path, test_runner = '')
      @package_path = package_path
      @test_runner  = test_runner || 'android.test.InstrumentationTestRunner'
    end

    def valid?
      !analyzed_package.nil?
    end

    def name
      analyzed_package.package_name
    end

    def path
      package_path
    end

    def version_name
      analyzed_package.version_name
    end

    def version_code
      analyzed_package.version_code
    end

    def test_runner
      @test_runner
    end

    private
    attr_reader :package_path

    def analyzed_package
      @analyzed_package ||= Rubotium::Apk::AndroidApk.new(package_path)
    end
  end
end
