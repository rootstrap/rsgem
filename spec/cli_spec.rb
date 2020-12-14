# frozen_string_literal: true

RSpec.describe 'CLI' do
  describe 'rsgem version' do
    it 'returns the version' do
      expect(`./exe/rsgem version`.strip).to eq RSGem::VERSION
    end

    it 'returns the version using the alternative -v option' do
      expect(`./exe/rsgem -v`.strip).to eq RSGem::VERSION
    end

    it 'returns the version using the alternative v option' do
      expect(`./exe/rsgem v`.strip).to eq RSGem::VERSION
    end

    it 'returns the version using the alternative --version option' do
      expect(`./exe/rsgem --version`.strip).to eq RSGem::VERSION
    end
  end

  describe 'rsgem new NAME --ci=VALUE' do
    after { `rm -rf #{gem_name}` }

    let(:gem_name) { 'testing_cli' }

    subject { `./exe/rsgem new #{gem_name}` }

    it 'creates a new gem' do
      expect(subject).to include('Install Reek')
      expect(subject).to include('Install Rubocop')
      expect(subject).to include('Install Simplecov')
      expect(subject).to include('Clean gemfile')
      expect(subject).to include('Ignore gemfile.lock')
      expect(subject).to include('Add CI configuration for Github Actions')
      expect(subject).to include('Bundle dependencies')
      expect(subject).to include('Run rubocop')
      expect(File.exist?(gem_name)).to eq true
    end

    context 'with travis as the CI provider' do
      subject { `./exe/rsgem new #{gem_name} --ci=travis` }

      it 'creates a new gem with travis configuration' do
        expect(subject).to include('Add CI configuration for Travis')
        expect(File.exist?("#{gem_name}/.travis.yml")).to eq true
      end
    end

    context 'with github actions as the CI provider' do
      subject { `./exe/rsgem new #{gem_name} --ci=github_actions` }

      it 'creates a new gem with github actions configuration' do
        expect(subject).to include('Add CI configuration for Github Actions')
        expect(File.exist?("#{gem_name}/.github/workflows/ci.yml")).to eq true
      end
    end

    context 'github config' do
      subject { `./exe/rsgem new #{gem_name} --ci=github_actions` }

      context 'is set' do
        it 'does not issue a warning or modify the gemspec' do
          expect(subject).to_not match(
            /Warning: No git username set, setting change_me for now/
          )
          expect(subject).to_not match(
            /Warning: No git email set, setting change_me@notanemail.com for now/
          )
        end
      end

      context 'not set' do
        let!(:previous_git_user_name) { `git config user.name`.strip }
        let!(:previous_git_user_email) { `git config user.email`.strip }

        before do
          `git config user.name ""`
          `git config user.email ""`
        end

        it 'creates a new gem with placeholder information' do
          expect(subject).to match(
            /No git user set./
          )
        end

        after do
          `git config user.name "#{previous_git_user_name}"`
          `git config user.email "#{previous_git_user_email}"`
        end
      end
    end
  end

  describe 'rsgem new NAME --bundler=VALUE' do
    after { `rm -rf #{gem_name}` }

    let(:gem_name) { 'testing_cli' }
    let(:options) { '--exe' }

    subject { `./exe/rsgem new #{gem_name} --bundler=#{options}` }

    it { is_expected.to include('Gem created with bundler options: --exe') }

    context 'with two options' do
      let(:options) { "'--exe --ext'" }

      it { is_expected.to include('Gem created with bundler options: --exe --ext') }
    end
  end

  describe 'rsgem new NAME --bundler=VALUE --ci=VALUE' do
    after { `rm -rf #{gem_name}` }

    let(:gem_name) { 'testing_cli' }

    subject { `./exe/rsgem new #{gem_name} --bundler=--ext --ci=github_actions` }

    it 'works with both options' do
      expect(subject).to include('Gem created with bundler options: --ext')
      expect(subject).to include('Add CI configuration for Github Actions')
    end
  end
end
