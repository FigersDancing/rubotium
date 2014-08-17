require 'android_apk'

module Rubotium
  class Package
    def initialize(package_path)
      @package_path = package_path
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

    private
    attr_reader :package_path

    def analyzed_package
      @analyzed_package ||= AndroidApk.analyze(package_path)
    end
  end
end
