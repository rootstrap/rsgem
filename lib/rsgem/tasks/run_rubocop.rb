# frozen_string_literal: true

module RSGem
  module Tasks
    class RunRubocop
      attr_reader :context, :output

      def initialize(context:)
        @context = context
      end

      def run
        puts "\tRubocop:"
        @output = `cd #{context.folder_path} && bundle exec rubocop -a`
        puts "\t\t#{last_line}"
      end

      private

      def last_line
        @output.split("\n").last
      end
    end
  end
end
