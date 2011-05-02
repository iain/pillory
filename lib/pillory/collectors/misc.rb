require 'pillory/collectors/base'

module Pillory

  module Collectors

    class Misc < Base

      def run
        { 'git' => git, 'base_dir' => base_dir }
      end

      def git
        `git rev-parse HEAD`
      end

      def base_dir
        Dir.pwd
      end

    end

  end

end
