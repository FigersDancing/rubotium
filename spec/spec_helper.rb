require 'simplecov'
require 'coveralls'
require 'fixtures/javap_classes'
require 'fixtures/jar_contents'
require 'fixtures/adb_results'
require 'fixtures/adb_devices_results'
require 'rspec/mocks'

SimpleCov.formatter = Coveralls::SimpleCov::Formatter

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
  SimpleCov::Formatter::HTMLFormatter,
  Coveralls::SimpleCov::Formatter
]

SimpleCov.start do
  add_filter "/spec/"
end

require 'rubotium'
