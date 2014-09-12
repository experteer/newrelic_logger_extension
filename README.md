# Newrelic Logger Extension

patch a logger instance to send a specified servity level as custom metric to
newrelic. The original logger handling is kept unchanged.

The login message is not send to newrelic only the location where the logging
happend is sent.

Also keep in mind that newrelic as a limit of ~2000 custom metrics which means
if you have to many locations where logging happend this might become an issue.

## Installation

Add this line to your application's Gemfile:

    gem 'newrelic_logger_extension'

And then execute:

    $ bundle

## Usage

to use this in for example an Rails application, first make sure newrelic is
setup and then create a new initilizer like this

``` ruby
%w(info warn error).each do |level|
  NewrelicLoggerExtension.inject_logger(Rails.logger, level)\
end
```

This will add the newrelic custom metric logging to the servity level `info`,
`warn` and `error`.

## Contributing

1. Fork it ( https://github.com/[my-github-username]/newrelic_logger_extension/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
