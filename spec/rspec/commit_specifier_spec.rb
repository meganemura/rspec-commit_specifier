require 'spec_helper'

describe RSpec::CommitSpecifier do
  it 'has a version number' do
    expect(RSpec::CommitSpecifier::VERSION).not_to be nil
  end

  it 'does something useful' do
    expect(false).to eq(true)
  end
end
