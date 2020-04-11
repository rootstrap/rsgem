# frozen_string_literal: true

require 'rsgem/version'
require 'rsgem/gem'
require 'rsgem/context'
require 'rsgem/tasks/add_code_analysis'
require 'rsgem/tasks/add_dependency'
require 'rsgem/tasks/clean_gemfile'
require 'rsgem/tasks/ignore_gemfile_lock'
require 'rsgem/tasks/clean_gemspec'
require 'rsgem/tasks/run_rubocop'
require 'rsgem/dependencies/base_dependency'
require 'rsgem/dependencies/rake'
require 'rsgem/dependencies/reek'
require 'rsgem/dependencies/rspec'
require 'rsgem/dependencies/rubocop'
require 'rsgem/dependencies/simplecov'

module RSGem
end
