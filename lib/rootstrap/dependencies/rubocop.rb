# frozen_string_literal: true

module Rootstrap
  module Dependencies
    Rubocop = Base.new(
      config_file_source: "#{File.dirname(__FILE__)}/support/rubocop.yml",
      config_file_destination: '.rubocop.yml',
      name: 'rubocop'
    )
  end
end
