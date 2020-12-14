# frozen_string_literal: true

module RSGem
  class Gem
    attr_reader :options

    def initialize(options)
      @options = options
    end

    def create
      puts 'Creating gem...'
      create_gem
      ensure_author
      add_code_analysis
      add_dependencies
      clean_gemfile
      ignore_gemfile_lock
      add_ci_provider
      clean_gemspec
      set_bundled_files
      set_license_file
      bundle_dependencies
      run_rubocop
      puts "#{context.gem_name} created"
    end

    private

    def add_ci_provider
      Tasks::AddCIProvider.new(context: context).call
    end

    def add_code_analysis
      Tasks::AddCodeAnalysis.new(context: context).call
    end

    def add_dependencies
      [
        Dependencies::Rake,
        Dependencies::Reek,
        Dependencies::RSpec,
        Dependencies::Rubocop,
        Dependencies::Simplecov
      ].each do |dependency|
        Tasks::AddDependency.new(context: context, dependency: dependency).call
      end
    end

    def clean_gemfile
      Tasks::CleanGemfile.new(context: context).call
    end

    def clean_gemspec
      Tasks::CleanGemspec.new(context: context).call
    end

    def context
      @context ||= Context.new(options: options)
    end

    def create_gem
      Tasks::CreateGem.new(context: context).call
    end

    def ensure_author
      Tasks::EnsureAuthor.new(context: context).call
    end

    def ignore_gemfile_lock
      Tasks::IgnoreGemfileLock.new(context: context).call
    end

    def run_rubocop
      Tasks::RunRubocop.new(context: context).call
    end

    def bundle_dependencies
      Tasks::BundleDependencies.new(context: context).call
    end

    def set_bundled_files
      Tasks::SetBundledFiles.new(context: context).call
    end

    def set_license_file
      Tasks::SetLicenseFile.new(context: context).call
    end
  end
end
