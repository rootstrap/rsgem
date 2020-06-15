# frozen_string_literal: true

module RSGem
  module Dependencies
    # This is the latest stable version working correctly with codeclimate
    # 0.18+ does not work currently https://github.com/codeclimate/test-reporter/issues/413
    Simplecov = Base.new(name: 'simplecov', version: '~> 0.17.1',
                         post_install_task: RSGem::Tasks::SimpleCovPostInstall)
  end
end
