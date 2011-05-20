require 'rspec/core/formatters/base_formatter'

# using absolute path here, because the rest of the pillory gem is not loaded at this time
# it might be outside the Gemfile
require File.expand_path('../coverage_parser', __FILE__)


Pillory::CoverageParser.start


module Pillory

  class RspecFormatter < ::RSpec::Core::Formatters::BaseFormatter

    def start_dump
      output.puts(pillory_data.to_yaml)
    end

    def pillory_data
      { 'coverage' => coverage, 'examples' => parsed_examples }
    end

    def coverage
      Pillory::CoverageParser.stop
    end

    def parsed_examples
      examples.map do |example|
        attrs = [ :description, :full_description, :execution_result, :file_path, :pending, :location ].map do |attr|
          value = example.send(attr)
          if attr == :execution_result && value[:exception]
            value = value.dup
            value[:exception] = serialize_exception(value[:exception])
          end
          [ attr.to_s, value ]
        end
        Hash[attrs]
      end
    end

    def serialize_exception(exception)
      { :name => exception.class.to_s, :message => exception.message, :backtrace => exception.backtrace }
    end

  end

end
