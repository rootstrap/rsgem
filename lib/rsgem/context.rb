# frozen_string_literal: true

module RSGem
  class Context
    attr_reader :options

    def initialize(options:)
      @options = options

      raise MissingGemNameError unless options[:gem_name]
    end

    def bundler_options
      @bundler_options ||= options[:bundler_options]
    end

    def ci_provider
      @ci_provider ||= begin
        return RSGem::Constants::DEFAULT_CI_PROVIDER unless (name = options[:ci_provider])

        RSGem::Constants::CI_PROVIDERS.detect do |provider|
          provider.name == name
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

    def test_spec_path
      "#{folder_path}/spec/#{gem_name}_spec.rb"
    end

    def gem_path
      "#{folder_path}/lib/#{gem_name}.rb"
    end

    def version_file_path
      "#{folder_path}/lib/#{gem_name}/version.rb"
    end
  end
end
