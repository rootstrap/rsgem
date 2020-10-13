# frozen_string_literal: true

module RSGem
  module Tasks
    class EnsureAuthor < Base
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
        unless system('git config user.email')
          puts "Warning: No git email set, setting #{TEMP_EMAIL} for now,
                please change this before publishing your gem."
          gemspec.gsub!(/spec.email\s+=\s+.+/,
                        "spec.email = ['#{TEMP_EMAIL}']")
        end

        unless system('git config user.name')
          puts "Warning: No git username set, setting #{TEMP_USERNAME} for now,
                please change this before publishing your gem."
          gemspec.gsub!(/spec.authors\s+=\s+.+/,
                        "spec.authors = ['#{TEMP_USERNAME}']")
        end

        write_gemspec
      end
    end
  end
end
