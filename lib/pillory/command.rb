require 'optparse'

module Pillory

  class Command

    attr_reader :args, :options

    def initialize(args)
      @args    = args
      @options = {
        :out     => STDOUT,
        :path    => Dir.pwd,
        :verbose => false,
        :config  => "config/pillory.rb"
      }
    end

    def parse
      parser.parse(args)
    end

    def parsed_options
      parse
      options
    end

    private

    def parser
      OptionParser.new do |opts|

        opts.banner = "Usage: pillory [options]"

        opts.on '-o', '--out FILE', 'Where to write the output to. When not specified, it goes to STDOUT.' do |file|
          options[:out] = file
        end

        opts.on '-c', '--config FILE', 'Load different config file (default is config/pillory.rb)' do |config|
          options[:config] = config
        end

        opts.on '-p', '--path PATH', 'The root path of the project (default is current directory)' do |path|
          options[:path] = path
        end

        opts.on '-u', '--url URL', 'Send data to the data collecting URL' do |url|
          options[:url] = url
        end

        opts.on '-v', '--[no-]verbose', 'Show expanded output' do |verbose|
          options[:verbose] = verbose
        end

        opts.on_tail '--version', 'Show this version' do
          require 'pillory/version'
          puts "Pillory version #{Pillory::VERSION}"
          exit
        end

        opts.on_tail '-h', '--help', "You're looking at it" do
          puts opts
          exit
        end

      end
    end

  end

end
