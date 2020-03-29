# frozen_string_literal: true

module Rootstrap
  class Gem
    attr_reader :gem_name

    def initialize(gem_name:)
      @gem_name = gem_name
    end

    def create
      `bundle gem #{gem_name}`

      add_dependencies
      clean_gemfile

      # TODO: Remove gems from Gemfile
      # TODO: Add a rake task for code analysis
      # TODO: Configure CI
    end

    private

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
  end
end
