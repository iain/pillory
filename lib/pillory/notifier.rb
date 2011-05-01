require 'net/http'
require 'uri'

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
      res = Net::HTTP.post_form(uri, output)
    end

    def uri
      @uri ||= URI.parse(url)
    end

    def url
      options[:url]
    end

  end

end
