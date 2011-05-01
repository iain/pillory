require 'rspec/core/formatters/base_formatter'

if RUBY_VERSION >= '1.9'
  require 'coverage'
  Coverage.start
end

module Pillory

  class RspecFormatter < ::RSpec::Core::Formatters::BaseFormatter

    def start_dump
      if RUBY_VERSION >= '1.9'
        result = Coverage.result.select { |k,v| k =~ /\A#{Dir.pwd}/ }
        output.puts result.to_yaml
      end
    end

  end

end
