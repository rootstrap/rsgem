# frozen_string_literal: true

module RSGem
  class Context
    attr_reader :options

    def initialize(options:)
      @options = options

      raise Errors::MissingGemName unless options[:gem_name]
    end

    def bundler_options
      @bundler_options ||= options[:bundler_options]
    end

    def ci_provider
      @ci_provider ||= begin
        if (name = options[:ci_provider])
          RSGem::Constants::CI_PROVIDERS.detect do |provider|
            provider.name == name
          end
        else
          RSGem::Constants::DEFAULT_CI_PROVIDER
        end
      end
    end

    def gemfile_path
      "#{folder_path}/Gemfile"
    end

    def gem_name
      @gem_name ||= options[:gem_name]
    end

    def gemspec_path
      "#{folder_path}/#{gem_name}.gemspec"
    end

    def license_path
      "#{folder_path}/LICENSE.txt"
    end

    def folder_path
      `pwd`.sub("\n", '/') + gem_name
    end

    def gitignore_path
      "#{folder_path}/.gitignore"
    end

    def rakefile_path
      "#{folder_path}/Rakefile"
    end

    def spec_helper_path
      "#{folder_path}/spec/spec_helper.rb"
    end
  end
end
