# frozen_string_literal: true

module Rootstrap
  class Gem
    attr_reader :gem_name

    def initialize(gem_name:)
      @gem_name = gem_name
    end

    def create
      `bundle gem #{gem_name}`

      add_code_analysis
      add_dependencies
      clean_gemfile
      ignore_gemfile_lock
    end

    private

    def add_code_analysis
      Tasks::AddCodeAnalysis.new(context: context).add
    end

    def add_dependencies
      [
        Dependencies::Rake,
        Dependencies::Reek,
        Dependencies::RSpec,
        Dependencies::Rubocop,
        Dependencies::Simplecov
      ].each do |dependency|
        Tasks::AddDependency.new(context: context, dependency: dependency).add
      end
    end

    def clean_gemfile
      Tasks::CleanGemfile.new(context: context).clean
    end

    def context
      @context ||= Rootstrap::Context.new(gem_name: gem_name)
    end

    def ignore_gemfile_lock
      Rootstrap::Tasks::IgnoreGemfileLock.new(context: context).ignore
    end
  end
end
