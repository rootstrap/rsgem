# frozen_string_literal: true

module RSGem
  module CLI
    module Commands
      extend Dry::CLI::Registry

      register 'new', New
      register 'version', Version, aliases: ['v', '-v', '--version']
    end
  end
end
