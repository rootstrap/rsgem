# frozen_string_literal: true

module RSGem
  module Tasks
    class SetLicenseFile < Base
      def perform
        license[2] = 'Copyright (c) 2020 Rootstrap'
        write

        puts "\tLICENSE file updated"
      end

      private

      def license
        @license ||= File.readlines(context.license_path)
      end

      def write
        File.open(context.license_path, 'w') do |file|
          file.puts license
        end
      end
    end
  end
end
