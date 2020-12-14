# frozen_string_literal: true

module RSGem
  module Tasks
    class AddCIProvider < Base
      OUTPUT = OutputStruct.new(name: :output_name)

      def perform
        context.ci_provider.install(context)
      end

      def output_name
        "Add CI configuration for #{context.ci_provider.display_name}"
      end
    end
  end
end
