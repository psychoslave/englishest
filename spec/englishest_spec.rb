# frozen_string_literal: true

RSpec.describe Englishest do
  it "has a version number" do
    expect(Englishest::VERSION).not_to be nil
  end

  it "is possible to call comparable operators with aliasing methods" do
    Englishest::Comparable::ALIASES.each do |operator, monikers|
      monikers.each{ expect(1.send(operator, 1)).to eq(1.send(_1, 1)) }
      unless %i[=~ !~].include? operator
        monikers.each{ expect(?a.send(operator, ?a)).to eq(?a.send(_1, ?a)) }
      else
        monikers.each{ expect(?a.send(operator, /a/)).to eq(?a.send(_1, /a/)) }
      end
    end
  end
end
