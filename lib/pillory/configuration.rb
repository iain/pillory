require 'singleton'

module Pillory

  class Configuration

    include Singleton

    def self.configure(&block)
      instance.instance_eval(&block)
    end

    attr_reader :options

    def initialize
      @options = {}
      default_configuration
    end

    def collectors
      collectors = {}
      options[:collectors].each do |key, value|
        collectors[key] = options[:global].merge(value) if value[:enabled]
      end
      collectors
    end

    def default_configuration
      options[:global] = {
        :patterns => %w(app/**/*.rb lib/**/*.rb),
        :color    => true
      }
      options[:collectors] = {
        :flay                 => { :enabled => true      },
        :rspec                => { :enabled => rspec?    },
        :misc                 => { :enabled => true      },
        :cucumber             => { :enabled => cucumber? },
        :changes              => { :enabled => git?      },
        :reek                 => { :enabled => true      },
        :roodi                => { :enabled => true      },
        :rails_best_practices => { :enabled => rails?    },
        :stats                => { :enabled => rails?    },
        :flog                 => { :enabled => true      }
      }
    end

    def rspec?
      File.exist?("spec")
    end

    def cucumber?
      File.exist?("features")
    end

    def git?
      File.exist?('.git')
    end

    def rails?
      File.exist?('config/environment.rb') && File.exist?('app')
    end

  end

end
