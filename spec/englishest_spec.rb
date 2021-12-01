# frozen_string_literal: true

RSpec.describe Englishest do
  it "has a version number" do
    expect(Englishest::VERSION).not_to be nil
  end

  it "enables to call ideographic operators with aliased methods" do
    Englishest.covered_types.each do |type|
      Object.const_get("::Englishest::#{type}::ALIASES").each do |operator, monikers|
        next if operator == :~

        monikers.each { expect(1.send(operator, 1)).to eq(1.send(_1, 1)) } unless operator == :=~

        if %i[=~ !~].include? operator
          monikers.each { expect("a".send(operator, /a/)).to eq("a".send(_1, /a/)) }
        else
          monikers.each { expect("a".send(operator, "a")).to eq("a".send(_1, "a")) }
        end
      end
    end
  end

  it "provides at least one trigram for each alias set (irrespective of punctuation signs)" do
    # Return true if any word in a synonym list is less than 4 grapheme
    def hypotetragramable?(synonyms)
      synonyms.any? { _1.match(/\p{Alpha}*/)[0].size < 4 }
    end

    Englishest.covered_types.each do |type|
      Object.const_get("::Englishest::#{type}::ALIASES").each do |operator, monikers|
        expect(hypotetragramable?(monikers)).to be(true), "Fail on #{type}##{operator}"
      end
    end
  end

  it "enables to express all ordination relational operators through words using the -cede suffixal morpheme" do
    # Stricly lower than
    expect(0.precede?(1)).to be true
    expect(0.antecede?(1)).to be true
    expect(0.subcede?(1)).to be true # somewhat like subceed

    # Lower than or equal to
    # Not to be confused with subcede, succeed, subside or succeed
    expect(0.proconcede?(1)).to be true

    # Equal
    expect(0.concede?(0)).to be true

    # Greater than or equal to
    expect(1.prosupercede?(0)).to be true

    # Strictly greater than
    expect(1.postcede?(0)).to be true
    expect(1.excede?(0)).to be true
    expect(1.supercede?(0)).to be true
  end

  it "provides a rationale behind the whimsy specifications on -cede word familly" do
    <<~                           ❧ RAVELLED RATIONALE ☙
                                            ❦

      The basic idea here is to provide a list of word that end in -cede in
      combination with prefixal morphemes marking logical, spatial or temporal
      ordering, such as pre-, post-, etc.

      The idea emerged as several words ending in -cede appeared at the first
      list that was generated for these aliases.

      From an etymological point of view, -cede is attached to the Latin
      cedere/cedo, meaning inter alia "to turn out, happen".

      Both subcede and supercede are rather rare terms, but where still considered
      relevant in the current scope. Supercede is a bit less rare, but generally
      dictionaries will mark it as a misspell of supersede: this is not the case
      here. Actually it turn out that both are judged relevant here, having
      considered their respective etymologies.

                                         ❦
                               ❧ RAVELLED RATIONALE ☙
  end

  it "is possible to express affirmation and denial through methods" do
    expect(true.positive?).to be true
    expect(true.negative?).to be false
    expect(false.positive?).to be false
    expect(false.negative?).to be true

    expect(true.consent?).to be true
    expect((1 + 1).consent?(2)).to be true
    expect(true.nod?).to be true
    expect((1 + 1).nod?(2)).to be true

    expect(true.dissent?).to be false
    expect(true.deny?).to be false
    expect(true.axe?).to be false
    expect((1 + 1).dissent?(2)).to be false
    expect((1 + 1).dissent?(3)).to be true
    # Numeric conventions should still hold
    expect(-1.negative?).to be true
    expect(-1.positive?).to be false
    expect(0.negative?).to be false
    expect(0.positive?).to be false
    expect(1.negative?).to be false
    expect(1.positive?).to be true

    # beware of precedence regarding unary negation prefixal operator
    def zero
      # this is really to make Rubocop unoffensed…
      0
    end
    expect((!zero).positive?).to be false
    expect(!zero.positive?).to be true # That is !(0.positive?)
    # nil should also stay with usual ruby semantic
    expect(nil.negative?).to be true
  end

  it "enables to call the unary prefix matching operator with usual verbs" do
    $_ = <<~LARRY_WALL
      There's really no way to fix this and still keep Perl pathologically
      eclectic.
    LARRY_WALL
    expect(/ally/.index_of_first_hot_matching).to eq ~ /ally/
    expect(/ally/.hot).to eq(/ally/.index_of_first_hot_matching)

    $LAST_READ_LINE = <<~YUKIHIRO_MATSUMOTO
      Ruby inherited the Perl philosophy of having more than one way to do the
      same thing. I inherited that philosophy from Larry Wall, who is my hero
      actually.
    YUKIHIRO_MATSUMOTO
    expect(spot(/ally/)).to eq ~ /ally/
    expect(win(/ally/)).to eq spot(/ally/)
  end
end
