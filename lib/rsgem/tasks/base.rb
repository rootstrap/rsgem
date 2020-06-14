# frozen_string_literal: true

module RSGem
  module Tasks
    #
    # Base class for task objects.
    # Child classes must implement the instance method +perform+.
    #
    class Base
      attr_reader :context, :extras

      def initialize(context:, **extras)
        @context = context
        @extras = extras
      end
    end
  end
end
