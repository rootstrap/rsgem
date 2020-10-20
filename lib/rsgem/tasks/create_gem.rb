# frozen_string_literal: true

module RSGem
  module Tasks
    class CreateGem < Base
      OUTPUT = OutputStruct.new(
        name: 'Create gem',
        success: :success_message
      )

      def perform
        return if system(shell_command, out: '/dev/null')

        raise RSGem::Errors::Base, "Failed to run `bundle gem'. Check bundler is installed in "\
                                   "your system or install it with `gem install bundler'.`"
      end

      private

      def bundler_options
        context.bundler_options
      end

      def success_message
        "Gem created with bundler options: #{bundler_options}" if bundler_options
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
