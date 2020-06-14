# frozen_string_literal: true

RSpec.describe RSGem::Gem do
  gem_name = 'test'

  describe '#create' do
    context 'with default configuration' do
      before(:all) do
        described_class.new(gem_name: gem_name).create
      end
      after(:all) do
        `rm -rf ./#{gem_name}`
      end

      let(:list_files) { `ls -a`.split("\n") }
      let(:list_files_gem) { `ls -a #{gem_name}`.split("\n") }
      let(:gemspec) { File.read("./#{gem_name}/#{gem_name}.gemspec") }
      let(:gemfile) { File.read("./#{gem_name}/Gemfile") }
      let(:gitignore) { File.read("./#{gem_name}/.gitignore") }
      let(:rakefile) { File.read("./#{gem_name}/Rakefile") }
      let(:travis) { File.read("./#{gem_name}/.travis.yml") }
      let(:expected_travis) { File.read('./lib/rsgem/support/travis.yml') }

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

      it 'updates the gemspec files config' do
        expect(gemspec).to include "spec.files = Dir['LICENSE.txt', 'README.md', 'lib/**/*']"
      end

      it 'adds travis configuration file' do
        expect(travis).to eq expected_travis
      end

      it 'does not create a github actions configuration file' do
        expect(File.exist?("./#{gem_name}/.github/workflows")).to eq false
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

    context 'with github actions as ci provider' do
      before(:all) do
        described_class.new(gem_name: gem_name, ci_provider: 'github_actions').create
      end
      after(:all) do
        `rm -rf ./#{gem_name}`
      end

      let(:github_actions) { File.read("./#{gem_name}/.github/workflows/ci.yml") }
      let(:expected_github_actions) { File.read('./lib/rsgem/support/github_actions.yml') }

      it 'adds github actions configuration file' do
        expect(github_actions).to eq expected_github_actions
      end

      it 'does not create a travis configuration file' do
        expect(File.exist?("./#{gem_name}/.travis.yml")).to eq false
      end
    end

    context 'when gem name options is missing' do
      it 'raises a missing gem name error' do
        expect { described_class.new({}).create }.to raise_error(RSGem::MissingGemNameError)
      end
    end

    context 'using bundler options' do
      before(:all) do
        described_class.new(gem_name: gem_name, bundler_options: '--ext --exe').create
      end
      after(:all) do
        `rm -rf ./#{gem_name}`
      end

      it 'adds the exe and ext folders' do
        expect(File.exist?("./#{gem_name}/exe")).to eq true
        expect(File.exist?("./#{gem_name}/ext")).to eq true
      end
    end

    context 'with failing bundler' do
      after { `rm -rf ./#{gem_name}` }

      it 'exits the process' do
        expect_any_instance_of(Object).to receive(:system).and_return(false)
        expect { described_class.new(gem_name: gem_name).create }.to raise_error(SystemExit)
      end
    end
  end
end
