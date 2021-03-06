# frozen_string_literal: true

module RSGem
  module Tasks
    class SetRequiredRubyVersion < Base
      OUTPUT = OutputStruct.new(name: 'Set required Ruby version')

      def perform
        set_required_ruby_version
        write
      end

      private

      def set_required_ruby_version
        gemspec.gsub!(
          /(spec.required_ruby_version.*)=(.*)\n/,
          "spec.required_ruby_version = Gem::Requirement.new('>= 2.5.0')\n"
        )
      end

      def gemspec
        @gemspec ||= File.read(context.gemspec_path)
      end

      def write
        File.open(context.gemspec_path, 'w') do |file|
          file.puts gemspec
        end
      end
    end
  end
end
