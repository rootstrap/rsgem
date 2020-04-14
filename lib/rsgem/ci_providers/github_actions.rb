# frozen_string_literal: true

module RSGem
  module CIProviders
    GithubActions = Base.new(
      config_file_source: "#{File.dirname(__FILE__)}/../support/github_actions.yml",
      config_file_destination: '.github/workflows/ci.yml',
      display_name: 'Github Actions',
      name: 'github_actions'
    )
  end
end
