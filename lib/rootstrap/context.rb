# frozen_string_literal: true

module Rootstrap
  class Context
    attr_reader :gem_name

    def initialize(gem_name:)
      @gem_name = gem_name
    end

    def gemfile_path
      "#{folder_path}/Gemfile"
    end

    def folder_path
      `pwd`.sub("\n", '/') + gem_name
    end

    def gitignore_path
      "#{folder_path}/.gitignore"
    end
  end
end
