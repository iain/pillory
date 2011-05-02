require 'rspec/core/formatters/base_formatter'

# using absolute path here, because the rest of the pillory gem is not loaded at this time
# it might be outside the Gemfile
require File.expand_path('../coverage_parser', __FILE__)


Pillory::CoverageParser.start


module Pillory

  class RspecFormatter < ::RSpec::Core::Formatters::BaseFormatter

    def start_dump
      output.puts({ 'coverage' => Pillory::CoverageParser.stop }.to_yaml)
    end

  end

end
