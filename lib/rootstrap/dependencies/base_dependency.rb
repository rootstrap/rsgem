# frozen_string_literal: true

module Rootstrap
  module Dependencies
    class Base
      attr_reader :config_file_destination, :config_file_source, :mode, :name, :version

      def initialize(config_file_source: nil, config_file_destination: nil, mode: :development,
                     name:, version: nil)
        @config_file_source = config_file_source
        @config_file_destination = config_file_destination
        @mode = mode # Either `development' or `runtime'
        @name = name
        @version = version ? "'#{version}'" : nil
      end

      def install(context)
        if config_file_source
          File.open("#{context.folder_path}/#{config_file_destination}", 'w') do |file|
            file.puts config_file_source_content
          end
        end

        puts "\t#{name.capitalize} installed"
      end

      private

      def config_file_source_content
        File.read(config_file_source)
      end
    end
  end
end
