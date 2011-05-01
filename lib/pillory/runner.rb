require 'pillory/collector'

module Pillory

  class Runner

    def self.output(*args)
      runner = new(*args)
      runner.run
      runner.output
    end

    attr_reader :options, :configuration, :output

    def initialize(options = {}, configuration)
      @options = options
      @configuration = configuration
      @output = {}
      load_config
    end

    def run
      collectors.each do |name, config|
        output.merge! Collector.output(name, options.merge(config))
      end
    end

    def load_config
      require config_path if load_config?
    end

    def path
      options[:path]
    end

    def out
      options[:out]
    end

    def config
      options[:config]
    end

    def config_path
      File.expand_path(config, path)
    end

    def collectors
      configuration.collectors
    end

    def load_config?
      config && File.exist?(config_path)
    end

  end

end
