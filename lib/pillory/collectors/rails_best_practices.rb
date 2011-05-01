require 'pillory/collectors/base'

module Pillory

  module Collectors

    class RailsBestPractices < Base

      def run
        capture "rails_best_practices --without-color"
      end

    end

  end

end
