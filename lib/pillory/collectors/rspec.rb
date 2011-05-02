require 'pillory/collectors/file_based'
require 'rspec/core/formatters/base_formatter'

module Pillory

  module Collectors

    class Rspec < FileBased

      attr_reader :bin, :specs

      def initialize(options = {})
        super
        @bin      = options[:bin]      || "rspec"
        @format   = options[:format]   || "progress"
        @color    = options[:color]    || false
        @specs    = options[:specs]    || "spec"
      end

      private

      def command(file)
        "#{bin} -I #{lib_dir} --format Pillory::RspecFormatter --out #{file.path} #{format} #{color} #{specs}"
      end

      def lib_dir
        File.expand_path('../../..', __FILE__)
      end

      def tempfile_name
        %w(rspec .yml)
      end

      def format
        "--format #{@format}"
      end

      def color
        @color ? "--color" : "--no-color"
      end

      def show_stdout?
        true
      end

      def show_stderr?
        true
      end

    end

  end

end
