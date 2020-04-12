# frozen_string_literal: true

RSpec.describe RSGem::Gem do
  gem_name = 'test'

  describe '#create' do
    before(:all) do
      @previous_git_user_name = `git config user.name`
      @previous_git_user_email = `git config user.email`
      `git config user.name Testing`
      `git config user.email testing@example.com`
      described_class.new(gem_name: gem_name).create
    end
    after(:all) do
      `git config user.name '#{@previous_git_user_name}'`
      `git config user.email '#{@previous_git_user_email}'`
      `rm -rf ./#{gem_name}`
    end

    let(:list_files) { `ls -a`.split("\n") }
    let(:list_files_gem) { `ls -a #{gem_name}`.split("\n") }
    let(:gemspec) { File.read("./#{gem_name}/#{gem_name}.gemspec") }
    let(:gemfile) { File.read("./#{gem_name}/Gemfile") }
    let(:gitignore) { File.read("./#{gem_name}/.gitignore") }
    let(:rakefile) { File.read("./#{gem_name}/Rakefile") }

    it 'creates a new folder' do
      expect(list_files).to include gem_name
    end

    it 'adds reek to the gemspec' do
      expect(gemspec).to include "spec.add_development_dependency 'reek'"
    end

    it 'adds rubocop to the gemspec' do
      expect(gemspec).to include "spec.add_development_dependency 'rubocop'"
    end

    it 'adds simplecov to the gemspec' do
      expect(gemspec).to include "spec.add_development_dependency 'simplecov', '~> 0.17.1'"
    end

    it 'adds rake to the gemspec if needed' do
      expect(gemspec.scan('rake').size).to eq 1
    end

    it 'adds rspec to the gemspec if needed' do
      expect(gemspec.scan('rspec').size).to eq 1
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

    context 'running inside the new gem' do
      before { Dir.chdir(gem_name) }
      after { Dir.chdir('../') }

      it 'makes the code analysis task pass' do
        load File.expand_path("../#{gem_name}/Rakefile", __dir__)
        expect { Rake::Task['code_analysis'].invoke }.not_to raise_error
      end
    end
  end
end
