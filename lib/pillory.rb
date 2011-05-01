require 'pillory/runner'
require 'pillory/configuration'
require 'pillory/notifier'

module Pillory

  def self.run(options)
    output = Runner.output(options, configuration)
    Notifier.notify(output, options)
  end

  def self.configure(&block)
    Configuration.configure(&block)
  end

  def self.configuration
    Configuration.instance
  end

end
