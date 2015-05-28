require 'spec_helper'

describe RSpec::CommitSpecifier do
  include described_class

  it 'has a version number' do
    expect(RSpec::CommitSpecifier::VERSION).not_to be nil
  end

  describe 'commits' do
    subject { commits }

    it 'returns commits' do
      expect(commits.count).to be >= 0
      expect(commits.map(&:message)).to all(be)
    end

    describe 'messages' do
      subject { super().map(&:message) }

      it { is_expected.to all(be) }
      it { is_expected.to all(match(/\A.*(?:\n\Z|\n\n)/)) }   # force second line to be blank
      it { is_expected.to all(match(/\A.*[^.]\n/)) }          # force first line to end with [^.]

      commands = %w(bundle rake rails guard sed)
      it { is_expected.to all(match(/\A(?:[A-Z0-9]|#{commands.join('|')})/)) }  # start with uppercase or command
    end
  end
end
