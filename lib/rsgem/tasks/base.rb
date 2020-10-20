# frozen_string_literal: true

module RSGem
  module Tasks
    #
    # Base class for task objects.
    # Child classes must implement the instance method +perform+.
    #
    class Base
      include Output

      attr_reader :context, :args

      def initialize(context:, **args)
        @context = context
        @args = args
      end

      def call
        with_output do
          perform
        end
      end
    end
  end
end
