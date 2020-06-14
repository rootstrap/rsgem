# frozen_string_literal: true

module RSGem
  module Dependencies
    class Base
      attr_reader :config_file_destination, :config_file_source, :mode, :name, :post_install_task,
                  :version

      def initialize(name:, **extras)
        @config_file_source = extras[:config_file_source]
        @config_file_destination = extras[:config_file_destination]
        @mode = extras[:mode] || 'development' # Either `development' or `runtime'
        @name = name
        @post_install_task = extras[:post_install_task]
        version = extras[:version]
        @version = version ? "'#{version}'" : nil
      end

      def install(context)
        if config_file_source
          File.open("#{context.folder_path}/#{config_file_destination}", 'w') do |file|
            file.puts config_file_source_content
          end
        end

        post_install_task&.new(context: context)&.perform

        puts "\t#{name.capitalize} installed"
      end

      private

      def config_file_source_content
        File.read(config_file_source)
      end
    end
  end
end
