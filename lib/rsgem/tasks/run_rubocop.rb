# frozen_string_literal: true

module RSGem
  module Tasks
    class RunRubocop < Base
      OUTPUT = OutputStruct.new(name: 'Run rubocop')

      def perform
        return if system("cd #{context.folder_path} && bundle exec rubocop -A",
                         %i[out err] => '/dev/null')

        raise RSGem::Errors::Base, 'Failed to run `bundle exec rubocop -A\''
      end
    end
  end
end
