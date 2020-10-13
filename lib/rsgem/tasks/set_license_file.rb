# frozen_string_literal: true

module RSGem
  module Tasks
    class SetLicenseFile < Base
      def perform
        license.gsub!(
          /.*Copyright.*/,
          "Copyright (c) #{Date.today.year} Rootstrap"
        )
        write

        puts Colors.colorize("\tLICENSE file updated", :green)
      end

      private

      def license
        @license ||= File.read(context.license_path)
      end

      def write
        File.open(context.license_path, 'w') do |file|
          file.puts license
        end
      end
    end
  end
end
