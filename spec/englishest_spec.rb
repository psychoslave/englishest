# frozen_string_literal: true

RSpec.describe Englishest do
  it "has a version number" do
    expect(Englishest::VERSION).not_to be nil
  end

  it "does something useful" do
    expect(1 <=> 1).to eq(1.trichotomize 1)
  end
end
