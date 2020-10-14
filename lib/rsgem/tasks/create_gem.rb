# frozen_string_literal: true

module RSGem
  module Tasks
    class CreateGem < Base
      def perform
        if system(shell_command)
          puts Colors.colorize(message, :green)
        else
          puts Colors.colorize("Failed to run `bundle gem'. "\
                               "Check bundler is installed in your system,
                               or install it with `gem install bundler'",
                               :red)
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
    end
  end
end
