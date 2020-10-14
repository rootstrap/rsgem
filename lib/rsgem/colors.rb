# frozen_string_literal: true

module RSGem
  class Colors
    MAPPING = {
      default: 39,
      red: 31,
      green: 32,
      yellow: 33,
      blue: 34,
      white: 97
    }.freeze

    class << self
      def colorize(string, color)
        "\e[#{color_code(color)}m#{string}\e[0m"
      end

      def color_code(color)
        MAPPING[color] || MAPPING[:default]
      end
    end
  end
end
