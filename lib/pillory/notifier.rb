require 'net/http'
require 'uri'
require 'pillory/version'
require 'yaml'

module Pillory

  class Notifier

    def self.notify(*args)
      new(*args).notify
    end

    attr_reader :output, :options

    def initialize(output, options)
      @output, @options = output, options
    end

    def notify
      res = Net::HTTP.post_form(uri, params)
      puts res.body
    end

    def uri
      @uri ||= URI.parse(url)
    end

    def url
      options[:url]
    end

    def params
      { :version  => Pillory::VERSION,
        :pillory  => output.to_yaml,
        :user     => `whoami`.strip,
        :hostname => `hostname`.strip }
    end

  end

end
