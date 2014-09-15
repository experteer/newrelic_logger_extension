require 'newrelic_logger_extension/version'
require 'binding_of_caller'
# require 'newrelic_rpm'

module NewrelicLoggerExtension
  SEPARATOR = '__'
  def self.inject_logger(logger, level = 'warn')
    return unless logger.respond_to? level.to_sym
    inject_servity_method(logger, level)
    inject_shared_methods(logger) unless logger.respond_to? :log_to_newrelic
  end
  def self.inject_servity_method(logger, level)
    logger.singleton_class.class_eval do
      define_method("#{level}_with_newrelic") do |*args|
        send("#{level}_without_newrelic", *args)
        log_to_newrelic level.capitalize, binding.of_caller(1).eval('self')
      end

      alias_method "#{level}_without_newrelic", level
      alias_method level, "#{level}_with_newrelic"
    end
  end
  def self.inject_shared_methods(logger)
    logger.singleton_class.class_eval do
      def log_to_newrelic(category, caller_class)
        caller_class = caller_class.class unless caller_class.class.to_s == 'Class'
        ::NewRelic::Agent.increment_metric("Custom/#{category}/#{caller_class}")
      end
    end
  end
end
