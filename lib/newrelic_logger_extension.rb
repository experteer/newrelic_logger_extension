require "newrelic_logger_extension/version"

module NewrelicLoggerExtension
  def self.eval_block
    def warn(*args)
      super
      puts "::NewRelic::Agent.increment_metric(Custom/Warning/#{format_caller(caller_locations(1).first)})"
      # ::NewRelic::Agent.increment_metric("Custom/Warning/#{format_caller(caller_locations(1).first)}")
    end

    def error(*args)
      super
      puts "::NewRelic::Agent.increment_metric(Custom/Error/#{format_caller(caller_locations(1).first)})"
      # ::NewRelic::Agent.increment_metric("Custom/Error/#{format_caller(caller_locations(1).first)}")
    end

    def info(*args)
      super
      puts "::NewRelic::Agent.increment_metric(Custom/Info/#{format_caller(caller_locations(1).first)})"
      # ::NewRelic::Agent.increment_metric("Custom/Info/#{format_caller(caller_locations(1).first)}")
    end

    def format_caller(kaller)
      kaller.path.split(/\/|\./)[-4..-2].join('__') << '__' << kaller.lineno
    rescue
      File.basename(kaller.path)
    end
  end
end
