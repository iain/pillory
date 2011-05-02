require 'pillory/collectors/file_based'

module Pillory

  module Collectors

    class Cucumber < FileBased

      attr_reader :bin, :features

      def initialize(options = {})
        super
        @bin      = options[:bin]      || "cucumber"
        @format   = options[:format]   || "progress"
        @color    = options[:color]    || false
        @profile  = options[:profile]  || "default"
        @features = options[:features] || "features"
      end

      private

      def command(file)
        [ {"PILLORY" => lib_dir }, "#{bin} --format Pillory::CucumberFormatter --out #{file.path} #{format} #{profile} #{color} #{features}" ]
      end

      def format
        "--format #{@format}"
      end

      def profile
        "--profile #{@profile}"
      end

      def color
        @color ? "--color" : "--no-color"
      end

      def lib_dir
        File.expand_path('../../cucumber_formatter', __FILE__)
      end

      def tempfile_name
        %w(cucumber .yml)
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
