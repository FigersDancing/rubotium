# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rubotium/version'

Gem::Specification.new do |spec|
  spec.name          = "rubotium"
  spec.version       = Rubotium::VERSION
  spec.authors       = ["Slawomir Smiechura"]
  spec.email         = ["slaw@gmail.com"]
  spec.summary       = "Run your Robotium tests with ease"
  spec.description   = "This gem allows to run Robotium tests in parallel on multiple devices"
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler",    "~> 1.5"
  spec.add_development_dependency "simplecov",  "0.8.2"
  spec.add_development_dependency "coveralls",  "0.7.0"
  spec.add_development_dependency "rspec",      "2.14.1"
  spec.add_development_dependency "rake"

  spec.add_dependency 'builder',  '3.2.2'
  spec.add_dependency 'trollop',  '2.0'
  spec.add_dependency 'parallel', '0.9.2'
end
