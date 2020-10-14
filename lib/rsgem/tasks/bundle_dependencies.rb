# frozen_string_literal: true

module RSGem
  module Tasks
    class BundleDependencies < Base
      def perform
        puts Colors.colorize("\tRunning bundle install:", :blue)
        @output = `cd #{context.folder_path} && bundle`
        puts Colors.colorize("\t\t#{last_line}", :blue)
      end

      private

      def last_line
        @output.split("\n").last
      end
    end
  end
end
