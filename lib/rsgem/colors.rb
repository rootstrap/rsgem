# frozen_string_literal: true

module RSGem
  class Colors
    class << self
      def colorize(string, color)
        "\e[#{color_code(color)}m#{string}\e[0m"
      end

      def color_code(color)
        {
          red: 31,
          green: 32,
          yellow: 33,
          blue: 34,
          white: 97,
        }[color] || 39
      end
    end
  end
end
