# frozen_string_literal: true

require_relative 'lib/rsgem/version'

Gem::Specification.new do |spec|
  spec.name          = 'rsgem'
  spec.version       = RSGem::VERSION
  spec.authors       = ['Juan Manuel Ramallo']
  spec.email         = ['ramallojuanm@gmail.com']

  spec.summary       = 'Generating gems the Rootstrap way'
  spec.homepage      = 'https://github.com/rootstrap/rsgem'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.3.0')

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/rootstrap/rsgem'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir['CHANGELOG.md', 'LICENSE.txt', 'README.md', 'bin/**/*', 'lib/**/*']
  spec.bindir        = 'exe'
  spec.executables   = ['rsgem']
  spec.require_paths = ['lib']

  spec.add_dependency 'dry-cli', '~> 0.6.0'
  spec.add_development_dependency 'pry', '~> 0.13.1'
  spec.add_development_dependency 'rake', '~> 13.0.1'
  spec.add_development_dependency 'reek', '~> 6.0.2'
  spec.add_development_dependency 'rspec', '~> 3.9.0'
  spec.add_development_dependency 'rubocop', '~> 1.0.0'
  spec.add_development_dependency 'simplecov', '~> 0.17.1'
end
