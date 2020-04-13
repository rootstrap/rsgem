# frozen_string_literal: true

module RSGem
  class Context
    attr_reader :options

    DEFAULT_CI_PROVIDER = RSGem::CIProviders::GithubActions

    def initialize(options:)
      @options = options

      raise MissingGemNameError unless options[:gem_name]
    end

    def ci_provider
      @ci_provider ||= case options[:ci_provider]
                       when 'travis'
                         RSGem::CIProviders::Travis
                       else
                         DEFAULT_CI_PROVIDER
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

    def folder_path
      `pwd`.sub("\n", '/') + gem_name
    end

    def gitignore_path
      "#{folder_path}/.gitignore"
    end

    def rakefile_path
      "#{folder_path}/Rakefile"
    end
  end
end
