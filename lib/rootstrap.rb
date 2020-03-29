# frozen_string_literal: true

require 'rootstrap/version'
require 'rootstrap/gem'
require 'rootstrap/context'
require 'rootstrap/tasks/add_dependency'
require 'rootstrap/tasks/clean_gemfile'
require 'rootstrap/tasks/ignore_gemfile_lock'
require 'rootstrap/dependencies/base_dependency'
require 'rootstrap/dependencies/rake'
require 'rootstrap/dependencies/reek'
require 'rootstrap/dependencies/rspec'
require 'rootstrap/dependencies/rubocop'
require 'rootstrap/dependencies/simplecov'

module Rootstrap
end
