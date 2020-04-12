# frozen_string_literal: true

require 'bundler/setup'
require 'simplecov'
require 'pry'
require 'rake'

SimpleCov.start do
  add_filter '/spec/'
end

require 'rsgem'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  original_stderr = $stderr
  original_stdout = $stdout
  config.before(:all) do
    $stderr = File.open(File::NULL, 'w')
    $stdout = File.open(File::NULL, 'w')
    @previous_git_user_name = `git config user.name`.strip
    @previous_git_user_email = `git config user.email`.strip
    `git config user.name Testing`
    `git config user.email testing@example.com`
  end

  config.after(:all) do
    `git config user.name '#{@previous_git_user_name}'`
    `git config user.email '#{@previous_git_user_email}'`
    $stderr = original_stderr
    $stdout = original_stdout
  end
end
