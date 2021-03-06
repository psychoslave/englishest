# frozen_string_literal: true

require "English"

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

        monikers.each do |moniker|
          # Integer does have an alias for =~, through Object, but it lakes those
          # specific to regular expressions, so we skip related test
          next if operator == :=~ && moniker == :index_of_first_matching

          # In all other cases, it is expected that aliases have the same effect
          # than the integer diadic operator, i.e. +1 == 1+ and +1.apt? 1+ are
          # evaluated to the same value.
          begin
            expect(1.send(operator, 1)).to eq(1.send(moniker, 1))
          rescue TypeError
            # Uncomment to debug
            # byebug
            raise TypeError
          end
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

  it "provides regular verb alternatives to usual arithmetic operators" do
    # prefixal unary plus
    expect(Numeric.new.method(:identity).original_name).to eq Numeric.new.method(:+@).name
    # prefixal unary minus
    expect(Numeric.new.method(:negation).original_name).to eq Numeric.new.method(:-@).name
    # Tests regarding the modulo operator
    # Note that +#modulo+ is actually part of the standard library, so it is not
    # tested here. Also Complex doesn't come with a +#%+ or %#modulo+ method
    # in the standard librabry.
    expect(Numeric.new.method(:lap).original_name).to eq Numeric.new.method(:%).name
    expect(5.lap(3)).to eq 2
    expect(5.5.lap(2)).to eq 1.5
    expect(5.5r.lap(2)).to eq 3/2r
    expect(5.lap(3)).to eq 2
    # addition
    expect(5.add(3)).to eq 8
    expect(5.5.append(2)).to eq 7.5
    expect(5.5r.plus(2)).to eq 15/2r
    expect(5i.supplement(3)).to eq(3 + 5i)
    # substraction
    expect(5.deduct(3)).to eq 2
    expect(5.5.minus(2)).to eq 3.5
    expect(5.5r.mow(2)).to eq 7/2r
    expect(5i.remove(3)).to eq(-3 + 5i)
    # multiplacation
    expect(5.cross(3)).to eq 15
    expect(5.5.dot(2)).to eq 11.0
    expect(5.5r.ex(2)).to eq 11/1r
    expect(5i.multiply(3)).to eq(15i)
    # division
    expect(5.cut(3)).to eq 1
    expect(5.5.divide(2)).to eq 2.75
    expect(5.5r.split(2)).to eq 11/4r
    expect(5i.cut(3)).to eq(Complex(0, 5/3r))
    # exponentiation
    expect(5.exponent(3)).to eq 125
    expect(5.5.power(2)).to eq 30.25
    expect(5.5r.vis(2)).to eq 121/4r
    expect(5i.wax(3)).to eq(-125i)
  end

  it "provides lexicalized alternatives to Integer specific operators" do
    expect(1.method(:bitwise_complement).original_name).to eq 1.method(:~).name
    expect(1.method(:bitwise_conjonction).original_name).to eq 1.method(:&).name
    expect(1.method(:bitwise_exclusive_disjunction).original_name).to eq 1.method(:^).name
    expect(1.method(:bitwise_inclusive_disjunction).original_name).to eq 1.method(:|).name
    expect(1.method(:additive_inverse).original_name).to eq 1.method(:-@).name
    expect(1.method(:left_arithmetic_shift).original_name).to eq 1.method(:<<).name
    expect(1.method(:right_arithmetic_shift).original_name).to eq 1.method(:>>).name
  end

  it "provides lexicalized alternatives to Time operators" do
    ere = Time.now
    expect(ere.method(:plus).original_name).to eq ere.method(:+).name
    expect(ere.method(:minus).original_name).to eq ere.method(:-).name
    expect(ere.method(:tetrachotomise).original_name).to eq ere.method(:<=>).name
    expect(ere.spy(ere.add(1))).to eq(-1)
    expect(ere.spy(ere)).to eq 0
    expect(ere.spy(ere.mow(1))).to eq 1
    expect(ere.spy(0)).to eq nil
  end

  it "provides lexicalized alternatives to String#%, including trigraphs" do
    expect("".method(:pig).original_name).to eq "".method(:%).name
    expect("".method(:format).original_name).to eq "".method(:%).name
    expect("".method(:form).original_name).to eq "".method(:%).name
    expect("".method(:saw).original_name).to eq "".method(:%).name
    expect("".method(:shape).original_name).to eq "".method(:%).name
  end

  it "provides lexicalized alternatives to Enumerator#+, including trigraphs" do
    tow = Enumerator.new { 0 }
    expect(tow.method(:add).original_name).to eq tow.method(:+).name
    expect(tow.method(:plus).original_name).to eq tow.method(:+).name
    expect(tow.method(:fuse).original_name).to eq tow.method(:+).name
  end

  it "provides usual English terms to String methods which lakes one" do
    non_english_terms = %i[b casecmp casecmp? chr crypt each_char
                           sub sub! gsub gsub! hex ljust rjust lstrip
                           rstrip strip oct ord rindex rpartition
                           succ succ! tr tr! tr_s unpack1]
    full_covering = non_english_terms.all? do |term|
      Englishest::String::INSTANCE_METHOD_ALIASES.keys.include?(term)
    end
    expect(full_covering).to be true
  end

  it "provides usual English terms to Array methods which lakes one" do
    non_english_terms = %i[assoc bsearch bsearch_index rassoc rindex to_ary eql?]
    full_covering = non_english_terms.all? do |term|
      Englishest::Array::INSTANCE_METHOD_ALIASES.keys.include?(term)
    end
    expect(full_covering).to be true

    # Ensure that +#eql?+ is not a mere alias from Kernel implementation
    expect([].tie?([])).to be true
  end

  it "provides usual English terms to Hash methods which lakes one" do
    non_english_terms = %i[assoc rassoc eql?]
    full_covering = non_english_terms.all? do |term|
      Englishest::Hash::INSTANCE_METHOD_ALIASES.keys.include?(term)
    end
    expect(full_covering).to be true

    # Ensure that +#eql?+ is not a mere alias from Kernel implementation
    expect({}.tie?({})).to be true
  end

  it "provides lexicalized trigraph alternatives to Range#step Range#%" do
    expect((0..1).method(:hop).original_name).to eq (0..1).method(:%).name
    expect((0..1).method(:pas).original_name).to eq (0..1).method(:%).name
  end

  it "provides lexicalized alternatives to square bracket Warning notations" do
    expect(Warning.method(:at)).to eq Warning.method(:[])
    expect(Warning.method(:in)).to eq Warning.method(:[]=)
  end

  it "provides lexicalized alternatives to Process::Status operators" do
    `:` # feel $? with a Process::Status
    expect($CHILD_STATUS.method(:pan).original_name).to eq $CHILD_STATUS.method(:&).name
    expect($CHILD_STATUS.method(:apt?).original_name).to eq $CHILD_STATUS.method(:==).name
    expect($CHILD_STATUS.method(:gee).original_name).to eq $CHILD_STATUS.method(:>>).name
  end

  it "provides lexicalized alternatives to square bracket ENV notations" do
    expect(ENV.method(:jet)).to eq ENV.method(:[])
    expect(ENV.method(:sow)).to eq ENV.method(:[]=)
  end

  it "provides lexicalized alternatives to Hash operators" do
    # Square bracket of singleton method
    expect(Hash.method(:create)).to eq Hash.method(:[])
    expect(Hash.method(:gig)).to eq Hash.method(:[])
    expect(Hash.method(:generate)).to eq Hash.method(:[])
    expect(Hash.method(:engender)).to eq Hash.method(:[])

    # Other instance method operators
    h = { a: 1 }
    expect(h.method(:den?)).to eq h.method(:<)
    expect(h.method(:ben?)).to eq h.method(:<=)
    expect(h.method(:pen?)).to eq h.method(:>)
    expect(h.method(:cap?)).to eq h.method(:>=)
    expect(h.method(:apt?)).to eq h.method(:==)
    expect(h.method(:of)).to eq h.method(:[])
    expect(h.method(:lay)).to eq h.method(:[]=)
    # make sure that +apt?+ is bind to +Hash#==+, and not inherited
    expect(h.apt?({ a: 1 })).to be true
  end

  it "provides lexicalized alternatives to logical bivalent operators" do
    expect(nil.and(false)).to eq false
    expect(nil.and(nil)).to eq false
    expect(nil.and(true)).to eq false

    expect(false.or(false)).to eq false
    expect(false.or(nil)).to eq false
    expect(false.or(true)).to eq true

    expect(true.nay(false)).to eq true
    expect(true.nay(nil)).to eq true
    expect(true.nay(true)).to eq false
  end

  it "provides lexicalized alternatives to basic operators on Array" do
    # +#&+ is basically the set of common elements between both arrays
    expect([].method(:common).original_name).to eq [].method(:&).name
    expect([].method(:conjunction).original_name).to eq [].method(:&).name
    expect([].method(:cross).original_name).to eq [].method(:&).name
    expect([].method(:fay).original_name).to eq [].method(:&).name
    expect([].method(:junction).original_name).to eq [].method(:&).name
    expect([].method(:shared).original_name).to eq [].method(:&).name

    # +#*+ stands for "join repeatly", with either a whole or a string parameter
    %i[autoecholalia autofuse autoloop dub din echo replicate repeat
       scale selfappend selfconcatenate selfduplicate
       selfexalt selfinsert selfpush selfreplicate].each do |term|
      expect([].method(term).original_name).to eq [].method(:*).name
    end

    expect([].method(:add).original_name).to eq [].method(:+).name
    expect([].method(:plus).original_name).to eq [].method(:+).name

    # Actually :== is defined in Comparable, and :<=> in Kernel, but this make
    # the local test set more thourough.
    expect([].method(:apt?).original_name).to eq [].method(:==).name
    expect([].method(:spy).original_name).to eq [].method(:<=>).name

    expect([].method(:absorb).original_name).to eq [].method(:<<).name
    expect([].method(:sap).original_name).to eq [].method(:<<).name

    expect([].method(:of).original_name).to eq [].method(:[]).name
    expect([].method(:lay).original_name).to eq [].method(:[]=).name
  end
  # TODO
  # it "provides terms with the morph -mix- for all modifying Array methods" do
  # end
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
        expect(hypotetragramable?(monikers.push(operator))).to be(true), "Fail on #{type}##{operator}"
      end
    rescue NameError
      # No singleton/instance method defined for this class, it's fine.
    end
  end

  it "enables to express all relational operators of Numeric descendants through trigraphs" do
    # Integer
    # 1 < 2
    expect((1).ere?(2)).to be true
    # 1 ??? 1
    expect((1).ben?(1)).to be true
    # 1 ??? 2
    expect((1).ben?(2)).to be true
    # 1 == 1
    expect((1).apt?(1)).to be true
    # 1 ??? 1
    expect((1).cap?(1)).to be true
    # 1 ??? 0
    expect((1).cap?(0)).to be true
    # 1 > 0
    expect((1).sky?(0)).to be true

    # Rational
    # 1r < 2r
    expect((1r).ere?(2r)).to be true
    # 1r ??? 1r
    expect((1r).ben?(1r)).to be true
    # 1r ??? 2r
    expect((1r).ben?(2r)).to be true
    # 1r == 1r
    expect((1r).apt?(1r)).to be true
    # 1r ??? 1r
    expect((1r).cap?(1r)).to be true
    # 1r ??? 0r
    expect((1r).cap?(0r)).to be true
    # 1r > 0r
    expect((1r).sky?(0r)).to be true

    # Float
    # 1.0 < 2.0
    expect((1.0).ere?(2.0)).to be true
    # 1.0 ??? 1.0
    expect((1.0).ben?(1.0)).to be true
    # 1.0 ??? 2.0
    expect((1.0).ben?(2.0)).to be true
    # 1.0 == 1.0
    expect((1.0).apt?(1.0)).to be true
    # 1.0 ??? 1.0
    expect((1.0).cap?(1.0)).to be true
    # 1.0 ??? 0.0
    expect((1.0).cap?(0.0)).to be true
    # 1.0 > 0.0
    expect((1.0).sky?(0.0)).to be true

    # Complexes
    # 1i == 1i
    expect((1i).apt?(1i)).to be true
    # Relational operators coming from Comparable are undefined on Complex.
    expect { (1i).ere?(1i) }.to raise_error NoMethodError
    expect { (1i).ben?(1i) }.to raise_error NoMethodError
    expect { (1i).cap?(1i) }.to raise_error NoMethodError
    expect { (1i).sky?(1i) }.to raise_error NoMethodError
  end

  it "enables to express Module's ordination relational operators through usual English terms" do
    # <
    expect(Object.subclass?(Kernel)).to be true
    # <=
    expect(Object.based_on?(Kernel)).to be true
    # >
    expect(Kernel.superclass?(Object)).to be true
    # >=
    expect(Kernel.superclass?(Object)).to be true

    # Note that #== and #=== are already tested elsewhere
  end

  it "enables to use IO with usual English terms" do
    expect($stdout.method(:pin).original_name).to eq $stdout.method(:<<).name
    expect(IO == Duction).to eq true
    expect(IO == Lug).to eq true
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
    expect(1.prosupercede?(1)).to be true

    # Strictly greater than
    expect(1.postcede?(0)).to be true
    expect(1.excede?(0)).to be true
    expect(1.supercede?(0)).to be true
  end

  it "provides a rationale behind the whimsy specifications on -cede word familly" do
    <<~???????????????????????????????????????????????????????????RAVELLED??RATIONALE?????
                                            ???

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

                                         ???
    ???????????????????????????????????????????????????????????RAVELLED??RATIONALE?????
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
    expect(true.nix?).to be false
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
      # this is really to make Rubocop unoffensed???
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

  it "enables to call the prefixed unary minus operator with lexicalized aliases" do
    expect(unary_minus(1)).to eq(-1)
    expect(pit(1)).to eq(-1)
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
