# frozen_string_literal: true

module RSGem
  module Dependencies
    Rubocop = Base.new(
      config_file_source: "#{File.dirname(__FILE__)}/../support/rubocop.yml",
      config_file_destination: '.rubocop.yml',
      name: 'rubocop-rootstrap'
    )
  end
end
