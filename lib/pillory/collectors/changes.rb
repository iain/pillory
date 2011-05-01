require 'pillory/collectors/base'

module Pillory

  module Collectors

    class Changes < Base

      def run
        changes = {}
        `git ls-files`.each_line do |file|
          cmd = "git log --oneline --full-history --follow --no-merges #{file.strip} | wc -l"
          changes[file.strip] = `#{cmd}`.to_i
        end
        changes
      end

    end

  end

end
