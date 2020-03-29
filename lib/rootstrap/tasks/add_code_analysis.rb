# frozen_string_literal: true

module Rootstrap
  module Tasks
    class AddCodeAnalysis
      attr_reader :context

      def initialize(context:)
        @context = context
      end

      def add
        write_to_rakefile
      end

      private

      def rakefile
        @rakefile ||= File.read("#{File.dirname(__FILE__)}/../support/Rakefile")
      end

      def write_to_rakefile
        File.open(context.rakefile_path, 'w') do |file|
          file.puts rakefile
        end
      end
    end
  end
end
