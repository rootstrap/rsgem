# frozen_string_literal: true

require 'rsgem/version'
require 'rsgem/gem'
require 'rsgem/errors/missing_gem_name_error'
require 'rsgem/ci_providers/base'
require 'rsgem/ci_providers/github_actions'
require 'rsgem/ci_providers/travis'
require 'rsgem/tasks/add_code_analysis'
require 'rsgem/tasks/add_dependency'
require 'rsgem/tasks/clean_gemfile'
require 'rsgem/tasks/ignore_gemfile_lock'
require 'rsgem/tasks/clean_gemspec'
require 'rsgem/tasks/run_rubocop'
require 'rsgem/tasks/set_bundled_files'
require 'rsgem/dependencies/base'
require 'rsgem/dependencies/rake'
require 'rsgem/dependencies/reek'
require 'rsgem/dependencies/rspec'
require 'rsgem/dependencies/rubocop'
require 'rsgem/dependencies/simplecov'
require 'rsgem/context'

module RSGem
end
