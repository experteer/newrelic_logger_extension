require 'bundler'
Bundler.setup

require 'simplecov'
require 'coveralls'
SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
  SimpleCov::Formatter::HTMLFormatter,
  Coveralls::SimpleCov::Formatter
]
SimpleCov.start

Bundler.require(:default, :test)

require 'newrelic_logger_extension'
RSpec.configure do |config|
  config.run_all_when_everything_filtered = true
  config.filter_run :focus

  config.order = 'random'
end
# Dir['./spec/support/**/*.rb'].sort.each{ |f| require f }
