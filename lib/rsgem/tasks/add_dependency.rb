# frozen_string_literal: true

module RSGem
  module Tasks
    class AddDependency < Base
      def perform
        return if already_installed?

        add_dependency
        write_to_gemspec
        dependency.install(context)
      end

      private

      def add_dependency
        gemspec_file.gsub!(/end\n\z/, code)
        gemspec_file << "\nend"
      end

      def already_installed?
        gemspec_file.match? Regexp.new("('|\")#{dependency.name}('|\")")
      end

      def code
        text = ["  spec.add_#{dependency.mode}_dependency '#{dependency.name}'", dependency.version]
        text.compact.join(', ')
      end

      def dependency
        extras[:dependency]
      end

      def gemspec_file
        @gemspec_file ||= File.read(context.gemspec_path)
      end

      def write_to_gemspec
        File.open(context.gemspec_path, 'w') do |file|
          file.puts gemspec_file
        end
      end
    end
  end
end
