# frozen_string_literal: true

module RSGem
  class Gem
    attr_reader :options

    def initialize(options)
      @options = options
    end

    def create
      `bundle gem #{context.gem_name}`

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

    def clean_gemspec
      Tasks::CleanGemspec.new(context: context).clean
    end

    def context
      @context ||= Context.new(options: options)
    end

    def ignore_gemfile_lock
      Tasks::IgnoreGemfileLock.new(context: context).ignore
    end

    def run_rubocop
      Tasks::RunRubocop.new(context: context).run
    end

    def bundle_dependencies
      Tasks::BundleDependencies.new(context: context).run
    end

    def set_bundled_files
      Tasks::SetBundledFiles.new(context: context).set
    end
  end
end
