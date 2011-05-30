require 'yaml'

module Pillory

  class CoverageParser

    def self.start
      if coverage?
        require 'coverage'
        Coverage.start
        puts "Starting Coverage"
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
      Hash[ result.select { |file, lines| include?(file) } ]
    end

    def include?(file)
      tracked_files.inlude?(file)
    end

    def tracked_files
      @tracked_files ||= `git ls-files`.strip.split("\n").map { |file| File.join(Dir.pwd, file.strip) }
    end

  end

end
