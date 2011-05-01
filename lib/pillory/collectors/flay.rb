require 'pillory/collectors/base'

module Pillory

  module Collectors

    class Flay < Base

      def run
        capture "flay #{files.join(' ')}"
      end

    end

  end

end
