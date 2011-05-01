require 'cucumber/formatter/io'

module Pillory

  class CucumberFormatter

    def self.start
      if RUBY_VERSION >= '1.9'
        require 'coverage'
        Coverage.start
      end
    end

    include ::Cucumber::Formatter::Io

    def initialize(step_mother, path_or_io, options)
      @step_mother, @io, @options = step_mother, ensure_io(path_or_io, "pillory"), options
    end


    def after_features(features)
      if RUBY_VERSION >= '1.9'
        result = Coverage.result.select { |k,v| k =~ /\A#{Dir.pwd}/ }
        @io.puts result.to_yaml
      end
    end

  end

end
