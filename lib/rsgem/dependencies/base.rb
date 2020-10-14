# frozen_string_literal: true

module RSGem
  module Dependencies
    class Base
      attr_reader :config_file_destination, :config_file_source, :mode, :name, :post_install_task,
                  :version

      def initialize(name:, **args)
        @config_file_source = args[:config_file_source]
        @config_file_destination = args[:config_file_destination]
        @mode = args[:mode] || 'development' # Either `development' or `runtime'
        @name = name
        @post_install_task = args[:post_install_task]
        version = args[:version]
        @version = version ? "'#{version}'" : nil
      end

      def install(context)
        if config_file_source
          File.open("#{context.folder_path}/#{config_file_destination}", 'w') do |file|
            file.puts config_file_source_content
          end
        end

        post_install_task&.new(context: context)&.perform

        puts Colors.colorize("\t#{name.capitalize} installed", :green)
      end

      private

      def config_file_source_content
        File.read(config_file_source)
      end
    end
  end
end
