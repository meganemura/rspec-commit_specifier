# RSpec::GitSpecifier
[![Build Status](https://travis-ci.org/meganemura/rspec-git_specifier.svg?branch=master)](https://travis-ci.org/meganemura/rspec-git_specifier)

The collection of helper methods to test git something.

## Usage

```ruby
# spec_helper.rb
require 'rspec/commit_specifier'
```

```ruby
# repository_spec.rb
describe 'Repository' do

  include RSpec::GitSpecifier   # or RSpec.configuration.include RSpec::GitSpecifier
                                # it defines `commits` and other helper methods to test repository

  describe 'commit messages' do
    subject { commits.map(&:message) }

    it { is_expected.to all(be) }
    it { is_expected.to all(match(/\A.*(?:\n\Z|\n\n)/)) }   # force second line to be blank
    it { is_expected.to all(match(/\A.*[^.]\n/)) }          # force first line to end with [^.]

    # start with uppercase character or command
    commands = %w(bundle rake rails guard sed)
    it { is_expected.to all(match(/\A(?:[A-Z0-9]|#{commands.join('|')})/)) }
  end

  describe 'current branch name' do
    subject { current_branch.name }

    it { is_expected.to match(/[a-z0-9-]+/) }
  end
end
```
