require 'pillory/collectors/base'
require 'tempfile'

module Pillory

  module Collectors

    class FileBased < Base

      def run
        with_tempfile do |file|
          capture(*Array(command(file)))
        end
      end

      private

      def command(file)
        raise NotImplementedError
      end

      def with_tempfile
        file = Tempfile.new(tempfile_name)
        begin
          yield(file)
          result = file.read
        ensure
          file.close
        end
        result
      end

      def tempfile_name
        raise NotImplementedError
      end

    end

  end

end
