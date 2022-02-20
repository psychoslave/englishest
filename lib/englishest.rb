# frozen_string_literal: true

require_relative "englishest/version"
require "English"

# Encapsulate all the contrivances to allow a coding style using more English
# vocabulary, especially enabling to express ideas without ideographi operators.
module Englishest
  class Error < StandardError; end

  module BasicObject
    ALIASES = {
      "==": %i[apt? congruent? equipotent? equiquantal? equivalue? worth?],
      equal?: %i[equireferent? peg? univocal?],
      "!=": %i[inæqual? inequal? unequal? unlike? wry?],
      "!": %i[bad? con? negative? ko?],
      __id__: %i[badge bib emblem identifier insigne insignia],
      __send__: %i[address fax hop pst transmit],
      instance_eval: %i[contextually so tho wis],
      instance_exec: %i[aptly pat plumb suitably],
      method_missing: %i[gap lake vacant on_vacancy way_off],
      singleton_method_added: %i[hail hey hi on_attachment], # tie would match, but eql? will need a new short synonym
      singleton_method_removed: %i[ban ciao leave_taking on_detachment],
      singleton_method_undefined: %i[farewell nix on_unattachment]
      # TODO
      # '!': unary bivalent negation prefix aliasable has non-],
    }.freeze
  end

  module Object
    ALIASES = {
    }.freeze
  end

  module Regexp
    ALIASES = {
      "=~": %i[hit index_of_first_matching],
      # As a reminder the tilde implicitely match against $LAST_READ_LINE/$_
      # Ruby allow to call it both in suffixed and prefixed form, that is
      # +some_regexp.~+ and +~some_regexp+.
      #
      # Note that these aliases cover only the case of a method call suffixing a
      # Regexp object, like +some_regexp.index_of_first_hot_matching+. For a
      # prefixed method expression form, see +Englishest#spot+ bellow.
      "~": %i[hit_tacitely index_of_first_hot_matching hot
              index_of_first_matching_on_last_read_line]
    }.freeze
  end

  module String
    ALIASES = {
      "=~": %i[hit index_of_first_matching]
    }.freeze
  end

  module Comparable
    ALIASES = {
      "<": %i[afore? ahead? antecede? before? ere? inferior_to? less_than?
              lower_than? prior? subcede? subceed? smaller_than? precede?],
      "<=": %i[at_most? behind? ben? below? beneath? comprised? proconcede?
               under? underneath? within?],
      "==": %i[apt? concede?], # also has other aliases through BasicObject
      ">=": %i[above? accede? at_least? comprise? on? onward? prosupercede? upward? upon?],
      ">": %i[after? beyond? excede? exceed? greater_than? higher_than? over? outdo? outstrip? postcede? supercede?
              supersede? superior_to? top? upper_than?]
    }.freeze
  end

  module Kernel
    ALIASES = {
      eql?: %i[akin? equisummable? isoepitomizable? like? tie?],
      "!~": %i[absent? devoid? off? miss?],
      "===": %i[encompass? fit? gird?],
      "=~": %i[hit],
      "<=>": %i[trichotomise trichotomize spy wye],
      "`": %i[subshell run]
    }.freeze
  end

  # TODO
  # '=': %i[assign fix peg set],

  # Return list of submodules whose name matches a class or module that is
  # affected by the gem
  def self.covered_types
    Englishest.constants.grep_v(/VERSION|Error/)
  end

  # This make the bulk of the work of actually setting aliases, using ALIASES
  # constant in submodules of Englishest
  covered_types.each do |type|
    Object.const_get("::#{type}").class_eval do
      Object.const_get("::Englishest::#{self}::ALIASES").each do |operator, monikers|
        monikers.each { alias_method _1, operator }
      end
    end
  end

  # Treating some corner cases specifically
  class ::BasicObject
    # Alternative to the double bang prefix notation returning the result of
    # transtyping anything to either +true+ or +false+.
    def positive?
      !!self
    end
    alias good? positive?
    alias ok? positive?
    alias pro? positive?

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
    # Note that :ban?, :nay?, :nix?, :ort? might also have do the trick as alias
    alias axe? dissent?

    # $LAST_READ_LINE is locally binded, to define a synonymous method of the
    # unary prefixal matching operator which implicitely use it, the value it
    # holds in the calling context must be retrieved by some means. Here the
    # retained implementation is to stash the value in a global variable each
    # time its value change.
    # TODO: see if this could be implemented without global variable nor class
    # variable, as both are raising Rubocop offenses
    trace_var(:$LAST_READ_LINE, proc { |nub|
      $LAST_PUT_LINE = nub
    })

    def spot(pattern)
      $LAST_PUT_LINE =~ pattern
    end
    alias win spot
    alias reach spot
  end

  # Few additional feature that makes string more subject-verb oriented in an
  # "everything is object" spirit
  class ::String
    def subshell
      `#{self}`
    end
    alias run subshell
  end

  # SystemCallError has also a *class* method named +===+
  class ::SystemCallError
    class << self
      alias encompass? ===
      alias fit? ===
      alias gird? ===
   end
  end

  # Array has a class method +[]+ to create new instance encompassing parameters
  class ::Array
    class << self
      alias create []
      alias engender []
      alias gig []
   end
  end
end
