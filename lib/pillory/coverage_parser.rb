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
      parser.result
    end

    def self.coverage?
      RUBY_VERSION >= '1.9'
    end

    attr_reader :result, :input

    def initialize(input)
      @input  = input
      @result = []
    end

    def parse
      input.each do |file, lines|
        result << result_item(file, lines) if include?(file)
      end
    end

    def result_item(file, lines)
      { 'file' => file, 'content' => file_content(file), 'lines' => lines }
    end

    def include?(file)
      tracked_files.include?(file)
    end

    def tracked_files
      @tracked_files ||= `git ls-files`.strip.split("\n").map { |file| File.join(Dir.pwd, file.strip) }
    end

    def file_content(file)
      File.open(file, 'r:utf-8').read
    end

  end

end
