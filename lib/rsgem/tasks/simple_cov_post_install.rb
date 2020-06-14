# frozen_string_literal: true

module RSGem
  module Tasks
    class SimpleCovPostInstall < Base
      def perform
        spec_helper.sub!("require \"#{context.gem_name}\"", <<~RUBY)
          require 'simplecov'

          SimpleCov.start do
            add_filter '/spec/'
          end

          require '#{context.gem_name}'
        RUBY

        write
      end

      private

      def spec_helper
        @spec_helper ||= File.read(context.spec_helper_path)
      end

      def write
        File.open(context.spec_helper_path, 'w') do |file|
          file.puts spec_helper
        end
      end
    end
  end
end
