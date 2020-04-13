# frozen_string_literal: true

module RSGem
  module CLI
    module Commands
      class New < Dry::CLI::Command
        def self.ci_provider_options
          RSGem::Constants::CI_PROVIDERS.map { |ci| "'#{ci.name}'" }.join(', ')
        end

        desc 'Create a new gem'

        argument :gem_name, type: :string, required: true, desc: 'Name of your new gem'
        argument :ci_provider, type: :string, required: false,
                               desc: 'CI provider to use. '\
                                     "Available options are: #{ci_provider_options}. "\
                                     "Default option is 'github_actions'"

        example [
          'foo        # Creates a new gem called foo',
          'bar travis # Creates a new gem called bar, with travis as the CI provider'
        ]

        def call(**options)
          RSGem::Gem.new(gem_name: options[:gem_name], ci_provider: options[:ci_provider]).create
        end
      end
    end
  end
end
