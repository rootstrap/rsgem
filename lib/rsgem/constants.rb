# frozen_string_literal: true

module RSGem
  module Constants
    CI_PROVIDERS = [
      RSGem::CIProviders::GithubActions,
      RSGem::CIProviders::Travis
    ].freeze
    DEFAULT_CI_PROVIDER = RSGem::CIProviders::GithubActions
  end
end
