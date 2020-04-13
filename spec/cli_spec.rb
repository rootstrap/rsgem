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

  describe 'rsgem new NAME [CI_PROVIDER]' do
    after { `rm -rf #{gem_name}` }

    let(:gem_name) { 'testing_cli' }
    let(:ci_provider) { nil }

    subject { `./exe/rsgem new #{gem_name} #{ci_provider}` }

    it 'creates a new gem' do
      expect(subject).to include('Reek installed')
      expect(subject).to include('Rubocop installed')
      expect(subject).to include('Simplecov installed')
      expect(subject).to include('Gemfile cleaned')
      expect(subject).to include('Gemfile.lock added to .gitignore')
      expect(subject).to include('Github Actions CI configuration added')
      expect(subject).to include('Rubocop:')
      expect(File.exist?(gem_name)).to eq true
    end

    context 'with travis as the CI provider' do
      let(:ci_provider) { 'travis' }

      it 'creates a new gem with travis configuration' do
        expect(subject).to include('Travis CI configuration added')
        expect(File.exist?("#{gem_name}/.travis.yml")).to eq true
      end
    end

    context 'with github actions as the CI provider' do
      let(:ci_provider) { 'github_actions' }

      it 'creates a new gem with github actions configuration' do
        expect(subject).to include('Github Actions CI configuration added')
        expect(File.exist?("#{gem_name}/.github/workflows/ci.yml")).to eq true
      end
    end
  end
end
