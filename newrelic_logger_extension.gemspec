# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'newrelic_logger_extension/version'

Gem::Specification.new do |spec|
  spec.name          = "newrelic_logger_extension"
  spec.version       = NewrelicLoggerExtension::VERSION
  spec.authors       = ["Andreas Eger"]
  spec.email         = ["andreas.eger@experteer.com"]
  spec.summary       = %q{extend a Logger instance to send warnings, errors and info to newrelic as custom metric}
  spec.description   = %q{extend a Logger instance to send warnings, errors and info to newrelic as custom metric}
  spec.homepage      = "https://www.github.com/experteer/newrelic_logger_extension"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "newrelic_rpm", ">= 3.9"

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
end
