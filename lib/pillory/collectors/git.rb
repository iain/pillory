require 'pillory/collectors/base'

module Pillory

  module Collectors

    class Git < Base

      def run
        capture "git rev-parse HEAD"
      end

    end

  end

end
