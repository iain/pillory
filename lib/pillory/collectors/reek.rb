require 'pillory/collectors/base'

module Pillory

  module Collectors

    class Reek < Base

      def run
        capture "reek --yaml #{files.join(' ')}"
      end

    end

  end

end
