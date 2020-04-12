# frozen_string_literal: true

module RSGem
  module CLI
    module Commands
      class New < Dry::CLI::Command
        desc 'Create a new gem'

        argument :gem_name, type: :string, required: true, desc: 'Name of your new gem'

        def call(gem_name:)
          RSGem::Gem.new(gem_name: gem_name).create
        end
      end
    end
  end
end
