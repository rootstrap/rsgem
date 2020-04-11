# frozen_string_literal: true

module RSGem
  module Tasks
    class AddCodeAnalysis
      attr_reader :context

      def initialize(context:)
        @context = context
      end

      def add
        File.open(context.rakefile_path, 'w') do |file|
          file.puts rakefile
        end
      end

      private

      def rakefile
        @rakefile ||= File.read("#{File.dirname(__FILE__)}/../support/Rakefile")
      end
    end
  end
end
