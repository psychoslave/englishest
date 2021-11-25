# frozen_string_literal: true

require_relative "englishest/version"

# Encapsulate all the contrivances to allow a coding style using more English
# vocabulary, especially enabling to express ideas without ideographi operators.
module Englishest
  class Error < StandardError; end

  module BasicObject
    ALIASES = {
      '==': %i[apt? congruent? equipotent? equiquantal? equivalue? worth?],
      'equal?': %i[equireferent? peg? univocal?],
      '!=': %i[dissent? inæqual inequal unequal? unlike? wry?]
      # TODO
      # '!': unary bivalent negation prefix aliasable has non-],
      # !
    }.freeze
  end

  module Object
    ALIASES = {
      'eql?': %i[akin? equisummable? isoepitomizable? like? tie?],
      '!~': %i[absent? devoid? off? miss?],
      '<=>': %i[trichotomise trichotomize spy wye],
      '===': %i[encompass? fit? gird?],
      '=~': %i[hit]
    }.freeze
  end

  module String
    ALIASES = {
      '=~': %i[hit]
    }.freeze
  end

  module Regexp
    ALIASES = {
      '=~': %i[hit]
      # TODO: unary ~ which matches rxp against the contents of $_
    }.freeze
  end

  module Comparable
    ALIASES = {
      '<': %i[afore? ahead? antecede? before? ere? inferior_to? less_than?
              lower_than? prior? subcede? subceed? smaller_than? precede?],
      '<=': %i[at_most? behind? ben? below? beneath? comprised? proconcede?
               under? underneath? within?],
      '==': %i[apt? concede?], # also has other aliases through BasicObject
      '>=': %i[above? accede? at_least? comprise? on? onward? prosupercede? upward? upon?],
      '>': %i[after? beyond? excede? exceed? greater_than? higher_than? over? outdo? outstrip? postcede? supercede?
              supersede? superior_to? top? upper_than?]
    }.freeze
  end

  # TODO
  # Kernel#` which allow shell execution

  # TODO
  # '=': %i[assign fix set],

  # Return list of submodules whose name matchas a class or module that is
  # affected by the gem
  def self.covered_types
    Englishest.constants.grep_v(/VERSION|Error/)
  end

  types = covered_types
  # Reopening a type require to explicit its class (class or module),
  # hereafter called ilk.
  ilks = types.map { Object.const_get(_1).class.to_s.downcase }
  # For each type containing an operator which is to be aliassed, reopen it
  # and generate aliases defined in the present eponimous submodules.
  types.zip(ilks).to_h.each do |type, ilk|
    eval <<~RUBY, binding, __FILE__, __LINE__ + 1
      #{ilk} ::#{type}
        ::Englishest::#{type}::ALIASES.each do |operator, monikers|
          monikers.each{ alias_method _1, operator }
        end
      end
    RUBY
  end

  # Treating some corner cases specifically
  class ::BasicObject
    alias_method :negative?, "!"

    # Alternative to the double bang prefix notation returning the result of
    # transtyping anything to either +true+ or +false+.
    def positive?
      !!self
    end

    # Consent tacitely mean "compared to truth" when no topic is given
    def consent?(topic = true)
      equal? topic
    end
    alias nod? consent?

    # Opposite of consent, although this is implemented as a fully automous
    # determination, which inter alia avoid some technical convonlutions
    def dissent?(topic = true)
      !equal?(topic)
    end
    alias deny? dissent?
    alias axe? dissent?
    # Note that :ban?, :nay?, :nix?, :ort? might have do the trick
  end

  # common numbers
  def zero
    0
  end
end
