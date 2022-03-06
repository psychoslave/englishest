# frozen_string_literal: true

RSpec.describe Englishest do
  it "has a version number" do
    expect(Englishest::VERSION).not_to be nil
  end

  it "enables to call ideographic operators with aliased methods" do
    Englishest.covered_types.each do |type|
      # List aliases whose identifier is strictly non-alphabetic
      operators = Object.const_get("::Englishest::#{type}::INSTANCE_METHOD_ALIASES")
                        .select { _1 =~ /^[^[:alpha:]]*$/ }
      operators.each do |operator, monikers|
        next if %i[~ ! `].include? operator

        monikers.each do
          # Integer does have an alias for =~, through Object, but it lakes those
          # specific to regular expressions, so we skip related test
          next if operator == :=~ && _1 == :index_of_first_matching

          # In all other cases, it is expected that aliases have the same effect
          # than the integer diadic operator, i.e. +1 == 1+ and +1.apt? 1+ are
          # evaluated to the same value.
          expect(1.send(operator, 1)).to eq(1.send(_1, 1))
        end

        # Compare evaluation of string operator against identic string with
        # their aliases counterparts, or using a matching regular expression
        # where adequate.
        if %i[=~ !~].include? operator
          monikers.each { expect("a".send(operator, /a/)).to eq("a".send(_1, /a/)) }
        else
          monikers.each { expect("a".send(operator, "a")).to eq("a".send(_1, "a")) }
        end
      end
    rescue NameError
      # No singleton/instance method defined for this class, it's fine.
    end
  end

  it "provides lexicalized alternatives to square bracket ENV notations" do
    expect(ENV.method(:jet)).to eq ENV.method(:[])
    expect(ENV.method(:sow)).to eq ENV.method(:[]=)
  end

  it "provides lexicalized alternatives to square brackets Array creation notation" do
    expect([1, :a, "a"]).to eq(Array.create(1, :a, "a"))
    expect([1, :a, "a"]).to eq(Array.gig(1, :a, "a"))
    expect([1, :a, "a"]).to eq(Array.generate(1, :a, "a"))
    expect([1, :a, "a"]).to eq(Array.engender(1, :a, "a"))
  end

  it "provides lexicalized alternatives to square brackets Dir matching" do
    pattern = "*[CR]*"
    expect(Dir.conform(pattern)).to eq(Dir[pattern])
    expect(Dir.native_global_match(pattern)).to eq(Dir[pattern])
    expect(Dir.orb(pattern)).to eq(Dir[pattern])
    expect(Dir.suit(pattern)).to eq(Dir[pattern])
  end

  it "provides lexicalized alternatives to backtilt subshell commands" do
    expect(`echo 'Sample test'`).to eq(subshell("echo 'Sample test'"))
    expect(`echo 'Sample test'`).to eq("echo 'Sample test'".subshell)
    expect(`echo 'Sample test'`).to eq(run("echo 'Sample test'"))
    expect(`echo 'Sample test'`).to eq("echo 'Sample test'".run)
  end

  it "provides alternatives to non-ideographic terms pertaining to equality" do
    expect(method(:eql?)).to eq method(:akin?)
    expect(method(:eql?)).to eq method(:equisummable?)
    expect(method(:eql?)).to eq method(:like?)
    expect(method(:eql?)).to eq method(:tie?)

    expect(method(:equal?)).to eq method(:peg?)
    expect(method(:equal?)).to eq method(:equireferent?)
  end

  it "provides alternatives to terms using underscore" do
    expect(method(:__id__)).to eq method(:bib)
    expect(method(:__id__)).to eq method(:badge)
    expect(method(:__id__)).to eq method(:bib)
    expect(method(:__id__)).to eq method(:emblem)
    expect(method(:__id__)).to eq method(:identifier)
    expect(method(:__id__)).to eq method(:insigne)
    expect(method(:__id__)).to eq method(:insignia)

    expect(method(:__send__)).to eq method(:address)
    expect(method(:__send__)).to eq method(:fax)
    expect(method(:__send__)).to eq method(:hop)
    expect(method(:__send__)).to eq method(:pst)
    expect(method(:__send__)).to eq method(:transmit)
  end

  it "provides at least one trigram for each alias set (irrespective of punctuation signs)" do
    # Return true if any word in a synonym list is less than 4 grapheme
    def hypotetragramable?(synonyms)
      synonyms.any? { _1.match(/\p{Alpha}*/)[0].size < 4 }
    end

    Englishest.covered_types.each do |type|
      Object.const_get("::Englishest::#{type}::INSTANCE_METHOD_ALIASES").each do |operator, monikers|
        expect(hypotetragramable?(monikers)).to be(true), "Fail on #{type}##{operator}"
      end
    rescue NameError
      # No singleton/instance method defined for this class, it's fine.
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

    expect(method(:positive?)).to eq method(:ok?)
    expect(method(:positive?)).to eq method(:good?)
    expect(method(:positive?)).to eq method(:pro?)

    expect(method(:negative?)).to eq method(:con?)
    expect(method(:negative?)).to eq method(:bad?)
    expect(method(:negative?)).to eq method(:ko?)
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
