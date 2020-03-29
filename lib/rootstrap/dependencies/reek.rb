# frozen_string_literal: true

module Rootstrap
  module Dependencies
    Reek = Base.new(
      config_file_source: "#{File.dirname(__FILE__)}/support/reek.yml",
      config_file_destination: '.reek.yml',
      name: 'reek'
    )
  end
end
