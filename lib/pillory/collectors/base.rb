require 'ansi/code'
require 'open3'

module Pillory

  module Collectors

    class Base
      include ANSI::Code

      attr_accessor :stdout, :stderr, :exit_status, :main

      attr_reader :patterns, :path

      def initialize(options = {})
        @patterns = options[:patterns]
        @path     = options[:path]
      end

      def run
        raise NotImplementedError
      end

      def run!
        puts magenta { "Running #{self.class.to_s}" }
        Dir.chdir path do
          @main = run
        end
      end

      def files
        Array(patterns).map { |pattern| Dir.glob(pattern) }.flatten
      end

      def output
        { 'main' => main, 'stdout' => stdout, 'stderr' => stderr, 'exit_status' => exit_status }
      end

      def stdout
        @stdout ||= ""
      end

      def stderr
        @stderr ||= ""
      end

      def capture(*command)
        Open3.popen3 *command do |stdin, stdout, stderr, wait_thr|
          stdout.each_char do |char|
            print char if show_stdout?
            self.stdout << char
          end
          stderr.each_char do |char|
            print char if show_stderr?
            self.stderr << char
          end
          self.exit_status = wait_thr.value.to_i
        end
        nil
      end

      def show_stdout?
        false
      end

      def show_stderr?
        false
      end

    end

  end

end
