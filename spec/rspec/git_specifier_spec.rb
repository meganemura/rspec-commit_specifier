require 'spec_helper'

describe RSpec::GitSpecifier do
  include described_class

  it 'has a version number' do
    expect(RSpec::GitSpecifier::VERSION).not_to be nil
  end

  describe 'commits without merge commits' do
    subject { commits.reject {|c| c.message.match(/\AMerge/) } }

    it 'returns commits' do
      expect(commits.count).to be >= 0
    end

    describe 'messages' do
      subject { super().map(&:message) }

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
  end

  describe 'current branch name' do
    subject { current_branch.name }

    it { is_expected.to match(/[a-z0-9-]+/) }
  end
end
