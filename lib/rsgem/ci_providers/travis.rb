# frozen_string_literal: true

module RSGem
  module CIProviders
    Travis = Base.new(config_file_source: "#{File.dirname(__FILE__)}/../support/travis.yml",
                      config_file_destination: '.travis.yml',
                      name: 'Travis')
  end
end
