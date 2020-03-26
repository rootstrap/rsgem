# frozen_string_literal: true

require_relative 'lib/rootstrap/version'

Gem::Specification.new do |spec|
  spec.name          = 'rootstrap'
  spec.version       = Rootstrap::VERSION
  spec.authors       = ['Juan Manuel Ramallo']
  spec.email         = ['ramallojuanm@gmail.com']

  spec.summary       = 'Generating gems the Rootstrap way'
  spec.homepage      = 'https://github.com/rootstrap/rootstrap-ruby'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.3.0')

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/rootstrap/rootstrap-ruby'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'rake', '~> 13.0.1'
  spec.add_development_dependency 'reek', '~> 5.6.0'
  spec.add_development_dependency 'rspec', '~> 3.9.0'
  spec.add_development_dependency 'rubocop', '~> 0.80.0'
  spec.add_development_dependency 'simplecov', '~> 0.17.1'
end
