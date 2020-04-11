# frozen_string_literal: true

module RSGem
  class Context
    attr_reader :gem_name

    def initialize(gem_name:)
      @gem_name = gem_name
    end

    def gemfile_path
      "#{folder_path}/Gemfile"
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
