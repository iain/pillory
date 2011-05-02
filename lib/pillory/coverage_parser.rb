require 'yaml'

module Pillory

  class CoverageParser

    def self.start
      if coverage?
        require 'coverage'
        Coverage.start
      end
    end

    def self.stop
      result if coverage?
    end

    def self.result
      parser = new(Coverage.result)
      parser.parse
    end

    def self.coverage?
      RUBY_VERSION >= '1.9'
    end

    attr_reader :result

    def initialize(result)
      @result = result
    end

    def parse
      parsed = {}
      result.each do |file, lines|
        if include?(file)
          parsed[file] = read_lines(file, lines)
        end
      end
      parsed
    end

    def include?(file)
      file =~ %r{\A#{Dir.pwd}}
    end

    def read_lines(file, lines)
      result = []
      contents = File.open(file, 'r:utf-8').each_line.with_index do |line, index|
        result << { line => lines[index] }
      end
      result
    end

  end

end
