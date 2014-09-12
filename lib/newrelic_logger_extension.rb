require 'newrelic_logger_extension/version'
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
        log_to_newrelic("#{level.capitalize}", caller_locations(1).first)
      end

      alias_method "#{level}_without_newrelic", level
      alias_method level, "#{level}_with_newrelic"
    end
  end
  def self.inject_shared_methods(logger)
    logger.singleton_class.class_eval do
      def log_to_newrelic(category, kaller)
        ::NewRelic::Agent.increment_metric("Custom/#{category}/#{format_caller(kaller)}")
      end

      def format_caller(kaller)
        (kaller.path.split(/\/|\./)[-4..-2] << kaller.lineno).join(SEPARATOR)
      rescue
        File.basename(kaller.path)
      end
    end
  end
end
