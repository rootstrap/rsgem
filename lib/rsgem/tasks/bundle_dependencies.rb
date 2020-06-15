# frozen_string_literal: true

module RSGem
  module Tasks
    class BundleDependencies < Base
      def perform
        puts "\tRunning bundle install:"
        @output = `cd #{context.folder_path} && bundle`
        puts "\t\t#{last_line}"
      end

      private

      def last_line
        @output.split("\n").last
      end
    end
  end
end
