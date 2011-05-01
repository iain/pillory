require 'pillory/collectors'

module Pillory

  class Collector

    def self.output(*args)
      collector = new(*args)
      collector.run
      collector.output
    end

    attr_reader :name, :args

    def initialize(name, *args)
      @name, @args = name.to_s, args
    end

    def run
      collector.run!
    end

    def output
      { name => collector.output }
    end

    def collector
      @collector ||= Collectors.get(class_name, name).new(*args)
    end

    def class_name
      @camelized ||= camelize(name)
    end

    # Ripped from ActiveSupport
    def camelize(lower_case_and_underscored_word, first_letter_in_uppercase = true)
      if first_letter_in_uppercase
        lower_case_and_underscored_word.to_s.gsub(/\/(.?)/) { "::#{$1.upcase}" }.gsub(/(?:^|_)(.)/) { $1.upcase }
      else
        lower_case_and_underscored_word.to_s[0].chr.downcase + camelize(lower_case_and_underscored_word)[1..-1]
      end
    end

  end

end
