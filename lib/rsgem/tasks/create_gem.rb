# frozen_string_literal: true

module RSGem
  module Tasks
    class CreateGem < Base
      def perform
        if system(shell_command)
          ensure_author
          puts message
        else
          puts "Failed to run `bundle gem'. "\
               "Check bundler is installed in your system, or install it with `gem install bundler'"
          exit false
        end
      end

      private

      def bundler_options
        context.bundler_options
      end

      def message
        [
          "\tGem created",
          ("with options: #{bundler_options}" if bundler_options)
        ].compact.join(' ')
      end

      def shell_command
        [
          "bundle gem #{context.gem_name} --test=rspec --coc --mit",
          bundler_options
        ].compact.join(' ')
      end

      def ensure_author
        temp_username = 'change_me'
        temp_email = 'change_me@notanemail.com'
        gemspec = File.read(context.gemspec_path)
        unless system('git config user.email')
          puts "Warning: No git email set, setting #{temp_email} for now, please change this before publishing your gem."
          gemspec.gsub!(/(spec.email[^\[]+)\[([^\]]+)/, "\\1\['#{temp_email}'")
        end

        unless system('git config user.name')
          puts "Warning: No git username set, setting #{temp_username} for now, please change this before publishing your gem."
          gemspec.gsub!(/(spec.authors[^\[]+)\[([^\]]+)/, "\\1\['#{temp_username}'")
        end

        File.write(context.gemspec_path, gemspec)
      end
    end
  end
end
