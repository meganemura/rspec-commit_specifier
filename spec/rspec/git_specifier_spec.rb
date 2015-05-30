require 'spec_helper'

describe RSpec::GitSpecifier do
  include described_class

  it 'has a version number' do
    expect(RSpec::GitSpecifier::VERSION).not_to be nil
  end

  describe 'gits' do
    subject { gits }

    it 'returns gits' do
      expect(gits.count).to be >= 0
      expect(gits.map(&:message)).to all(be)
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
