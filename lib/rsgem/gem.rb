# frozen_string_literal: true

module RSGem
  class Gem
    attr_reader :options

    def initialize(options)
      @options = options
    end

    def create
      create_gem
      add_code_analysis
      add_dependencies
      clean_gemfile
      ignore_gemfile_lock
      add_ci_provider
      clean_gemspec
      set_bundled_files
      bundle_dependencies
      run_rubocop
    end

    private

    def add_ci_provider
      context.ci_provider.install(context)
    end

    def add_code_analysis
      Tasks::AddCodeAnalysis.new(context: context).perform
    end

    def add_dependencies
      [
        Dependencies::Rake,
        Dependencies::Reek,
        Dependencies::RSpec,
        Dependencies::Rubocop,
        Dependencies::Simplecov
      ].each do |dependency|
        Tasks::AddDependency.new(context: context, dependency: dependency).perform
      end
    end

    def clean_gemfile
      Tasks::CleanGemfile.new(context: context).perform
    end

    def clean_gemspec
      Tasks::CleanGemspec.new(context: context).perform
    end

    def context
      @context ||= Context.new(options: options)
    end

    def create_gem
      Tasks::CreateGem.new(context: context).perform
    end

    def ignore_gemfile_lock
      Tasks::IgnoreGemfileLock.new(context: context).perform
    end

    def run_rubocop
      Tasks::RunRubocop.new(context: context).perform
    end

    def bundle_dependencies
      Tasks::BundleDependencies.new(context: context).perform
    end

    def set_bundled_files
      Tasks::SetBundledFiles.new(context: context).perform
    end
  end
end
