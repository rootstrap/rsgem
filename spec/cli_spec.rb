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
      expect(subject).to include('Reek installed')
      expect(subject).to include('Rubocop installed')
      expect(subject).to include('Simplecov installed')
      expect(subject).to include('Gemfile cleaned')
      expect(subject).to include('Gemfile.lock added to .gitignore')
      expect(subject).to include('Travis CI configuration added')
      expect(subject).to include('Running bundle install:')
      expect(subject).to include('Rubocop:')
      expect(File.exist?(gem_name)).to eq true
    end

    context 'with travis as the CI provider' do
      subject { `./exe/rsgem new #{gem_name} --ci=travis` }

      it 'creates a new gem with travis configuration' do
        expect(subject).to include('Travis CI configuration added')
        expect(File.exist?("#{gem_name}/.travis.yml")).to eq true
      end
    end

    context 'with github actions as the CI provider' do
      subject { `./exe/rsgem new #{gem_name} --ci=github_actions` }

      it 'creates a new gem with github actions configuration' do
        expect(subject).to include('Github Actions CI configuration added')
        expect(File.exist?("#{gem_name}/.github/workflows/ci.yml")).to eq true
      end
    end

    context 'without github config properly set' do
      let!(:previous_git_user_name) { `git config user.name`.strip }
      let!(:previous_git_user_email) { `git config user.email`.strip }

      before do
        `git config --unset user.name`
        `git config --unset user.email`
      end

      subject { `./exe/rsgem new #{gem_name} --ci=github_actions` }

      it 'creates a new gem with placeholder information' do
        expect(subject).to match(/Warning: No git username set, setting change_me for now/)
        expect(subject).to match(/Warning: No git email set, setting change_me@notanemail.com for now/)
      end

      after do
        `git config user.name #{previous_git_user_name}`
        `git config user.email #{previous_git_user_email}`
      end
    end
  end

  describe 'rsgem new NAME --bundler=VALUE' do
    after { `rm -rf #{gem_name}` }

    let(:gem_name) { 'testing_cli' }
    let(:options) { '--exe' }

    subject { `./exe/rsgem new #{gem_name} --bundler=#{options}` }

    it { is_expected.to include('Gem created with options: --exe') }

    context 'with two options' do
      let(:options) { "'--exe --ext'" }

      it { is_expected.to include('Gem created with options: --exe --ext') }
    end
  end

  describe 'rsgem new NAME --bundler=VALUE --ci=VALUE' do
    after { `rm -rf #{gem_name}` }

    let(:gem_name) { 'testing_cli' }

    subject { `./exe/rsgem new #{gem_name} --bundler=--ext --ci=github_actions` }

    it 'works with both options' do
      expect(subject).to include('Gem created with options: --ext')
      expect(subject).to include('Github Actions CI configuration added')
    end
  end
end
