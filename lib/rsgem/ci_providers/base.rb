# frozen_string_literal: true

module RSGem
  module CIProviders
    class Base
      attr_reader :config_file_destination, :config_file_source, :name, :display_name

      def initialize(config_file_source: nil, config_file_destination: nil, display_name:, name:)
        @config_file_source = config_file_source
        @config_file_destination = config_file_destination
        @display_name = display_name
        @name = name
      end

      def install(context)
        remove_travis(context)
        destination = "#{context.folder_path}/#{config_file_destination}"

        File.delete(destination) if File.exist?(destination)
        FileUtils.mkdir_p(File.dirname(destination))
        File.open(destination, 'w') do |file|
          file.puts config_file_source_content
        end

        puts Colors.colorize("\t#{display_name} CI configuration added", :green)
      end

      private

      def config_file_source_content
        File.read(config_file_source)
      end

      #
      # `bundle gem` adds travis by default
      #
      def remove_travis(context)
        travis_path = "#{context.folder_path}/.travis.yml"
        return unless File.exist?(travis_path)

        File.delete(travis_path)
      end
    end
  end
end
