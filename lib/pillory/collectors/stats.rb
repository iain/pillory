require 'pillory/collectors/base'

module Pillory

  module Collectors

    class Stats < Base

      def run
        capture "rake stats"
      end

    end

  end

end
