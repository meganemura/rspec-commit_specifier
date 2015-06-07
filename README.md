# RSpec::GitSpecifier
[![Build Status](https://travis-ci.org/meganemura/rspec-git_specifier.svg?branch=master)](https://travis-ci.org/meganemura/rspec-git_specifier)
[![Circle CI](https://circleci.com/gh/meganemura/rspec-git_specifier/tree/master.svg?style=svg)](https://circleci.com/gh/meganemura/rspec-git_specifier/tree/master)

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

    describe 'every lines' do
      subject { super().map { |messages| messages.lines.map(&:strip) } }

      it 'should be 72 chars or fewer' do
        expect(subject.map(&:size).max).to be <= 72
      end

      describe 'summary line' do
        subject { super().map(&:first) }

        it 'should be 50 chars or fewer' do
          expect(subject.map(&:size)).to all(be <= 50)
        end

        # start with uppercase character or command
        commands = %w(bundle rake rails guard sed)
        it { is_expected.to all(match(/\A(?:[A-Z0-9]|#{commands.join('|')})/)) }
      end
    end
  end

  describe 'current branch name' do
    subject { current_branch.name }

    it { is_expected.to match(/[a-z0-9-]+/) }
  end
end
```
