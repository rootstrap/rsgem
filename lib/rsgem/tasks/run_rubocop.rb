# frozen_string_literal: true

module RSGem
  module Tasks
    class RunRubocop < Base
      def perform
        puts "\tRubocop:"
        @output = `cd #{context.folder_path} && bundle exec rubocop -A`
        puts "\t\t#{last_line}"
      end

      private

      def last_line
        @output.split("\n").last
      end
    end
  end
end
