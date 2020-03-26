# frozen_string_literal: true

module Rootstrap
  module Tasks
    class AddDependency
      attr_reader :context, :dependency

      def initialize(context:, dependency:)
        @context = context
        @dependency = dependency
      end

      def add
        add_dependency
        write_to_gemspec
        dependency.install(context)
      end

      private

      def add_dependency
        gemspec_file.gsub!(/end\n\z/, code)
        gemspec_file << "\nend"
      end

      def code
        text = ["  spec.add_#{dependency.mode}_dependency '#{dependency.name}'", dependency.version]
        text.compact.join(', ')
      end

      def gemspec_path
        "#{context.folder_path}/#{context.gem_name}.gemspec"
      end

      def gemspec_file
        @gemspec_file ||= File.open(gemspec_path).read
      end

      def write_to_gemspec
        File.open(gemspec_path, 'w') do |file|
          file.puts gemspec_file
        end
      end
    end
  end
end
