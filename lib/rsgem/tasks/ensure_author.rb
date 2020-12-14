# frozen_string_literal: true

module RSGem
  module Tasks
    class EnsureAuthor < Base
      OUTPUT = OutputStruct.new(
        name: 'Ensure author',
        warning: :warning_message
      )
      TEMP_USERNAME = 'change_me'
      TEMP_EMAIL = 'change_me@notanemail.com'

      def perform
        ensure_author
      end

      private

      def gemspec
        @gemspec ||= File.read(context.gemspec_path)
      end

      def write_gemspec
        File.write(context.gemspec_path, gemspec)
      end

      def ensure_author
        return unless missing_git_user?

        gemspec.gsub!(/spec.email\s+=\s+.+/,
                      "spec.email = ['#{TEMP_EMAIL}']")

        gemspec.gsub!(/spec.authors\s+=\s+.+/,
                      "spec.authors = ['#{TEMP_USERNAME}']")
        write_gemspec
      end

      def missing_git_user?
        `git config user.email`.strip.empty? || `git config user.name`.strip.empty?
      end

      def warning_message
        return unless missing_git_user?

        "No git user set. Setting #{TEMP_EMAIL} and #{TEMP_USERNAME} in gemspec, "\
        'please change this before publishing your gem.'
      end
    end
  end
end
