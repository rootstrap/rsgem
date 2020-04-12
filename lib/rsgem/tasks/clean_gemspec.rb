# frozen_string_literal: true

module RSGem
  module Tasks
    class CleanGemspec
      attr_reader :context

      KEYS_TO_EMPTY = %w[summary description homepage].freeze

      def initialize(context:)
        @context = context
      end

      def clean
        comment_metadata!
        empty_keys!
        write
      end

      private

      def gemspec
        @gemspec ||= File.read(context.gemspec_path)
      end

      def empty_keys!
        KEYS_TO_EMPTY.each do |key|
          gemspec.gsub!(/(spec.#{key}.*)=(.*)\n/, "\\1= ''\n")
        end
      end

      def comment_metadata!
        gemspec.gsub!(/spec.metadata/, '# spec.metadata')
      end

      def write
        File.open(context.gemspec_path, 'w') do |file|
          file.puts gemspec
        end
      end
    end
  end
end
