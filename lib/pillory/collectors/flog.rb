module Pillory

  module Collectors

    class Flog < Base

      def run
        capture "flog --all --group --continue #{files.join(' ')}"
      end

    end

  end

end
