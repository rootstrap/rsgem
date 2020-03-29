# frozen_string_literal: true

RSpec.describe Rootstrap::Gem do
  gem_name = 'test'

  describe '#create' do
    before(:all) { described_class.new(gem_name: gem_name).create }
    after(:all) { `rm -rf ./#{gem_name}` }

    let(:list_files) { `ls -a`.split("\n") }
    let(:list_files_gem) { `ls -a #{gem_name}`.split("\n") }
    let(:gemspec) { File.read("./#{gem_name}/#{gem_name}.gemspec") }
    let(:gemfile) { File.read("./#{gem_name}/Gemfile") }
    let(:gitignore) { File.read("./#{gem_name}/.gitignore") }
    let(:rakefile) { File.read("./#{gem_name}/Rakefile") }

    it 'creates a new folder' do
      expect(list_files).to include gem_name
    end

    it 'adds the default gems to the gemspec' do
      expect(gemspec).to include(
        <<-RUBY
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'reek'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'simplecov', '~> 0.17.1'
        RUBY
      )
    end

    it 'assigns a version to simplecov' do
      expect(gemspec).to include "'simplecov', '~> 0.17.1'"
    end

    it 'adds the rubocop config file' do
      expect(list_files_gem).to include '.rubocop.yml'
    end

    it 'adds the reek config file' do
      expect(list_files_gem).to include '.rubocop.yml'
    end

    it 'removes the default gems from the gemfile' do
      expect(gemfile).not_to match(/gem /)
    end

    it 'includes the base gemspec in the gemfile' do
      expect(gemfile).to include 'gemspec'
    end

    it 'leaves only one last new line character in the gemfile' do
      expect(gemfile[gemfile.size - 2..gemfile.size].count("\n")).to eq 1
    end

    it 'adds the Gemfile.lock file into the git ignored files' do
      expect(gitignore).to include 'Gemfile.lock'
    end

    it 'adds the code analysis rake task to the Rakefile' do
      expect(rakefile).to include(
        <<~RUBY
          task :code_analysis do
            sh 'bundle exec rubocop lib spec'
            sh 'bundle exec reek lib'
          end
        RUBY
      )
    end
  end
end
