# frozen_string_literal: true

RSpec.describe Englishest do
  it "has a version number" do
    expect(Englishest::VERSION).not_to be nil
  end

  it "is possible to call ideographic operators with aliased methods" do
    Englishest.covered_types.each do |type|
      (eval "Englishest::#{type}::ALIASES").each do |operator, monikers|
        monikers.each{ expect(1.send(operator, 1)).to eq(1.send(_1, 1)) }
        unless %i[=~ !~].include? operator
          monikers.each{ expect(?a.send(operator, ?a)).to eq(?a.send(_1, ?a)) }
        else
          monikers.each{ expect(?a.send(operator, /a/)).to eq(?a.send(_1, /a/)) }
        end
      end
    end
  end

  it "is possible to express affirmation and denial through methods" do
    expect(true.positive?).to be true
    expect(true.negative?).to be false
    expect(false.positive?).to be false
    expect(false.negative?).to be true

    expect(true.consent?).to be true
    expect((1+1).consent? 2).to be true
    expect(true.nod?).to be true
    expect((1+1).nod? 2).to be true

    expect(true.dissent?).to be false
    expect(true.deny?).to be false
    expect(true.axe?).to be false
    expect((1+1).dissent? 2).to be false
    expect((1+1).dissent? 3).to be true
    # Numeric conventions should still hold
    expect(-1.negative?).to be true
    expect(-1.positive?).to be false
    expect(0.negative?).to be false
    expect(0.positive?).to be false
    expect(1.negative?).to be false
    expect(1.positive?).to be true
    # beware of precedence regarding unary negation prefixal operator
    expect(!!0.positive?).to be false
    expect((!!0).positive?).to be true
    # nil should also stay with usual ruby semantic
    expect(nil.negative?).to be true
  end
end
