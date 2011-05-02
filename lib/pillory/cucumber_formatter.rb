require 'cucumber/formatter/io'

# using absolute path here, because the rest of the pillory gem is not loaded at this time
# it might be outside the Gemfile
require File.expand_path('../coverage_parser', __FILE__)

module Pillory

  class CucumberFormatter

    def self.start
      Pillory::CoverageParser.start
    end

    include ::Cucumber::Formatter::Io

    def initialize(step_mother, path_or_io, options)
      @step_mother, @io, @options = step_mother, ensure_io(path_or_io, "pillory"), options
    end


    def after_features(features)
      @io.puts({ 'coverage' => Pillory::CoverageParser.stop }.to_yaml)
    end

  end

end
