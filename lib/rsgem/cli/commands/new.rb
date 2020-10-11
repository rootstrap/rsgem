# frozen_string_literal: true

module RSGem
  module CLI
    module Commands
      class New < Dry::CLI::Command
        desc 'Create a new gem'

        argument :gem_name, type: :string, required: true, desc: 'Name of your new gem'
        option :bundler, type: :string,
                         default: nil,
                         desc: 'Bundler options to use'
        option :ci, type: :string,
                    default: RSGem::Constants::DEFAULT_CI_PROVIDER.name,
                    values: RSGem::Constants::CI_PROVIDERS.map(&:name),
                    desc: 'CI provider to use'

        example [
          'foo                     # Creates a new gem called foo',
          'bar --ci=github_actions # Creates a new gem called bar, with GitHub Actions as the '\
          'CI provider',
          'foo_bar --bundler=--ext # Creates a new gem called foo_bar passing the --ext flag to '\
          'bundler'
        ]

        def call(**options)
          puts Colors.colorize("Creating a new gem #{options[:gem_name]}", :green)
          puts Colors.colorize("\tpassed in ci option = #{options[:ci]}", :green)
          puts Colors.colorize("\tpassed in bundler option = #{options[:ci]}", :green) unless options[:bundler].nil?
          RSGem::Gem.new(gem_name: options[:gem_name],
                         ci_provider: options[:ci],
                         bundler_options: options[:bundler]).create
        end
      end
    end
  end
end
