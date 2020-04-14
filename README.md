# `rsgem` - Rootstrap's gem generator

![build](https://github.com/rootstrap/rsgem/workflows/build/badge.svg)
[![Maintainability](https://api.codeclimate.com/v1/badges/c22da1693543a6eac7e9/maintainability)](https://codeclimate.com/github/rootstrap/rsgem/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/c22da1693543a6eac7e9/test_coverage)](https://codeclimate.com/github/rootstrap/rsgem/test_coverage)

`rsgem` is a tool to help you start developing gems with the defaults we use at Rootstrap.

## Installation

    $ gem install rsgem

We highly suggest to not include `rsgem` in your Gemfile.
`rsgem` is not a library, and should not affect the dependency tree of your application.

## Usage

```
rsgem new NAME [CI_PROVIDER]
```

RSGem will solve the following tasks for you:

1. Create a folder for your gem leveraging bundler's defaults. (You need bundler in your system)
1. Add the following dependencies:
    - [Rake](https://github.com/ruby/rake)
    - [Reek](https://github.com/troessner/reek)
    - [RSpec](https://github.com/rspec/rspec)
    - [Rubocop](https://github.com/rubocop-hq/rubocop)
    - [Simplecov](https://github.com/colszowka/simplecov)
        - We use Simplecov at 0.17.1 because that's the latest compatible version with CodeClimate.
1. Add configuration files for Reek and Rubocop with default Rootstrap's configuration.
1. Add a rake task to run Rubocop and Reek by calling `rake code_analysis`.
1. [Clean the Gemfile](https://github.com/rootstrap/tech-guides/blob/master/open-source/developing_gems.md#gemfilegemfilelockgemspec).
1. [Git ignore the Gemfile.lock](https://github.com/rootstrap/tech-guides/blob/master/open-source/developing_gems.md#gemfilegemfilelockgemspec)
1. Add a CI provider configuration. GitHub Actions and Travis are available providers. Travis is the default.
1. Set the bundled files to be a short list of files. By default the gem will bundle:
    - LICENSE.txt
    - README.md
    - lib/**/* (everything inside lib)
1. Apply Rubocop style fixes

#### Examples

```
rsgem new foo
```
Creates a new gem called foo.

```
rsgem new bar github_actions
```
Creates a new gem called bar that uses Github Actions as the CI provider.

#### Help

```
rsgem -h
```
Displays global help.

```
rsgem new -h
```
Displays help for the `new` command.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bundle exec rspec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/rootstrap/rsgem. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/rootstrap/rsgem/blob/master/CODE_OF_CONDUCT.md).


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Rootstrap project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/rootstrap/rsgem/blob/master/CODE_OF_CONDUCT.md).
