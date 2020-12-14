# frozen_string_literal: true

module RSGem
  module Tasks
    class BundleDependencies < Base
      OUTPUT = OutputStruct.new(name: 'Bundle dependencies')

      def perform
        return if system("cd #{context.folder_path} && bundle", out: '/dev/null')

        raise RSGem::Errors::Base
      end
    end
  end
end
