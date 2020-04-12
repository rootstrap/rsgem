# frozen_string_literal: true

module RSGem
  module CIProviders
    class Base
      attr_reader :config_file_destination, :config_file_source, :name

      def initialize(config_file_source: nil, config_file_destination: nil, name:)
        @config_file_source = config_file_source
        @config_file_destination = config_file_destination
        @name = name
      end

      def install(context)
        destination = "#{context.folder_path}/#{config_file_destination}"

        File.delete(destination) if File.exist?(destination)
        FileUtils.mkdir_p(File.dirname(destination))
        File.open(destination, 'w') do |file|
          file.puts config_file_source_content
        end

        puts "\t#{name} CI configuration added"
      end

      private

      def config_file_source_content
        File.read(config_file_source)
      end
    end
  end
end
