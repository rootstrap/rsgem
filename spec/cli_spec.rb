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

  describe 'rsgem new NAME' do
    after { `rm -rf #{gem_name}` }

    let(:gem_name) { 'testing_cli' }

    subject { `./exe/rsgem new #{gem_name}` }

    it 'creates a new gem' do
      expect(subject).to include('Reek installed')
      expect(subject).to include('Rubocop installed')
      expect(subject).to include('Simplecov installed')
      expect(subject).to include('Gemfile cleaned')
      expect(subject).to include('Gemfile.lock added to .gitignore')
      expect(subject).to include('Rubocop:')
      expect(File.exist?(gem_name)).to eq true
    end
  end
end
