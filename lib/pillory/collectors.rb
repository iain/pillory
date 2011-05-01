module Pillory

  module Collectors

    def self.get(class_name, name)
      if const_defined?(class_name)
        const_get(class_name)
      else
        require collectors[name]
        const_get(class_name)
      end
    end

    def self.collect(name, options = {})
      collector = collector(name).new(options)
      collector.run!
      collector.output
    end

    def self.collectors
      @collectors ||= Hash.new { |hash, key| hash[key] = "pillory/collectors/#{key}" }
    end

  end

end
