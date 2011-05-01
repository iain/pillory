require 'pillory/collectors/base'
require 'roodi'

module Pillory

  module Collectors

    class Roodi < Base

      def run
        runner = ::Roodi::Core::Runner.new
        files.each do |file|
          runner.check_file(file)
        end
        runner.errors
      end

    end

  end

end
