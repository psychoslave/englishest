# frozen_string_literal: true

require_relative "englishest/version"
require "English"

# Encapsulate all the contrivances to allow a coding style using more English
# vocabulary, especially enabling to express ideas without ideographic
# operators.
module Englishest
  # Class usable to throw errors specifically related to the Englishest module.
  class Error < StandardError; end

  # Return list of submodules whose name matches a class or module that is
  # affected by the gem
  def self.covered_types
    # All direct constants, except those with a purely internal utility,
    # supplemented with pertaining nested modules.
    Englishest.constants.grep_v(/VERSION|Error|Prefixal|Arithmophore/) +
      %i[Process::Status]
  end

  # Group material related to handling prefixed operators
  module Prefixal
    def unary_minus(object)
      -object
    end
    # Wiktionary gives "To bring (something) into opposition with something
    # else" for *pit*.
    alias pit unary_minus

    ##
    #
    # $LAST_READ_LINE is locally binded, to define a synonymous method of the
    # unary prefixal matching operator which implicitely use it, the value it
    # holds in the calling context must be retrieved by some means. Here the
    # retained implementation is to stash the value in a global variable each
    # time its value change.
    trace_var(:$LAST_READ_LINE, proc { |nub|
      $LAST_PUT_LINE = nub
    })

    def spot(pattern)
      $LAST_PUT_LINE =~ pattern
    end
    alias win spot
    alias reach spot
  end

  # Object is the default root of all Ruby objects.
  # Methods on Object are available to all classes unless explicitly overridden.
  #
  # Only two instance methods related to +equal?+ are added here, as well as
  # a global method to replace the +~+ unary prefix matching operator.
  class ::Object
    include Englishest::Prefixal

    # Alternative to the double bang prefix notation returning the result of
    # transtyping anything to either +true+ or +false+.
    def positive?
      !!self
    end
    alias good? positive?
    alias ok? positive?
    alias pro? positive?

    # Alternative to +equal?+, with a default value of +true+ for the provided
    # argument.
    # Semantically, the idea is that consenting tacitely means
    # "agreeing with truthness" of some expressed topic
    #
    # For the opposite test, +dissent?+ and its aliases is provided.
    def consent?(topic = true)
      equal? topic
    end
    # This provides a
    alias nod? consent?

    # Opposite of +consent?+, although this is implemented as a fully automous
    # determination, which inter alia avoid some technical convonlutions
    def dissent?(topic = true)
      !equal?(topic)
    end
    alias deny? dissent?
    # Note that +axe?+, +ban?+, +nay?+, and +ort?+ have also been
    # considered, but were reserved for other uses or dismissed as too uncommon
    # Cambridge dictionary gives "to stop, prevent, or refuse to accept
    # something" for *nix*.
    alias nix? dissent?
  end

  # ENV is a hash-like accessor for environment variables.
  ENV.singleton_class.class_eval do
    ##
    # :singleton-method: ENV::[name]
    # Returns the value for the environment variable +name+ if it exists.
    #
    # Note that unlike +ENV::fetch+, this method does not raise any error if the
    # requested key is valid and not set, but simply returns +nil+.
    #
    # This difference of behavior is taken into account in provided aliases.

    ##
    # Alternative to +ENV::[]+, that is, returns the value for the environment
    # variable name if it exists.
    #
    # This alias provide a trigraph which is moreover lexically close to the
    # classical get/set accessor identifiers. This let +get+ as a possible
    # alias for fetch, while giving a good hint on the fact that this method
    # is generally a quicker accessor – with less safety net.
    #
    # Merriam-Webster gives the following pertaining definition for jet:
    # transitive verb : to emit in a stream : spout
    # See: https://www.merriam-webster.com/dictionary/jet
    alias_method :jet, :[]

    ##
    # Trigraph alternative to +ENV::[]=+ and +ENV::store+.
    #
    # Merriam-Webster gives the following pertaining definition for sow:
    # To spread abroad; to propagate.
    # See: https://www.merriam-webster.com/dictionary/sow
    alias_method :sow, :[]=
  end

  # The ObjectSpace module contains a number of routines that interact
  # with the garbage collection facility and allow you to traverse all
  # living objects with an iterator.
  module ::ObjectSpace
    class << self
      ##
      # :method:  _id2ref
      # Converts an object id to a reference to the object.
      # May not be called on an object id passed as a parameter to a finalizer.

      ##
      # :method:  denote
      # Alternative regular verb to the underscorpe prefixed +_id2ref+.
      # Merriam-Webster gives the following pertaining definitionn for denote:
      # - to serve as a linguistic expression of the notion of : mean
      # - to stand for : designate
      # TODO: this doc seems ignored by Rdoc, understand why and fix this.
      alias denote _id2ref

      ##
      # Trigraph alternative regular verb to the underscorpe prefixed +_id2ref+.
      # Merriam-Webster gives the following pertaining definitionn for tab:
      # to single out : designate
      alias tab _id2ref
    end
  end

  # A String object has an arbitrary sequence of bytes, typically representing
  # text or binary data. Extensions provided by this library focus on making
  # more specific features around String usable with more classic lexical calls.
  class ::String
    # Allows to method-pipeline strings toward a subshell execution, in a more
    # subject-verb oriented manner than the default backtilt notation provided
    # by +Kernel#`+. Subjectively that can also be considered more aligned with
    # the "everything is object" spirit.
    #
    # The built-in syntax <tt>%x{...}</tt> is also an other option to achieve
    # the same facility.
    # All these mecanisms, including this very method, have the side effect of
    # setting +$?+ to the process status.
    #
    # Additional options, which don’t return the command output as call result, are:
    #   - +Kernel#exec+
    #   - +Kernel#spawn+
    #   - +Kernel#system+
    #
    # @return [String] Returns the standard output of running the calling string
    # in a subshell.
    def subshell
      `#{self}`
    end
    # Trigraph which, albeit a bit less precise on what it undercover than its
    # aliased version, is fully alligned with regular use of the word.
    alias run subshell
  end

  module Kernel
    INSTANCE_METHOD_ALIASES = {
      # Merriam-Webster gives "to provide or offer something equal to : equal"
      # for *tie*.
      eql?: %i[akin? equisummable? isoepitomizable? like? tie?],
      "!~": %i[absent? devoid? off? miss?],
      "===": %i[encompass? fit? gird?],
      "=~": %i[hit],
      # Wiktionary gives "To distinguish something as being different from
      # something else; to differentiate" for *spy*.
      "<=>": %i[quadrichotomise quadrichotomize tetrachotomise tetrachotomize
                spy],
      # quadrialate
      # quadriaxial
      "`": %i[subshell run],
      # Wiktionary gives "To be of use, have value." and "To have the strength
      # for, to be able to" for *dow*.
      respond_to?: %i[dow?],
      # Wiktionary gives "To move away; to go off" for mog
      exit: %i[mog],
      exit!: %i[mog!],
      # Wiktionary gives "To extend the hand to; hand or pass something" for
      # rax.
      extend: %i[rax]
    }.freeze
  end

  module Array
    # List of aliases provided for each class method indexed by its identifier
    SINGLETON_METHOD_ALIASES = {
      # create a new instance encompassing parameters
      "[]": %i[create engender generate gig]
    }.freeze

    INSTANCE_METHOD_ALIASES = {
      # Supplement changingly +self+ inserting +object+ at provided coordinates
      # Return +object+
      "[]=": %i[lay in],
      "[]": %i[of],
      # Merriam-Webster gives "to fit or join closely or tightly" for *fay*
      # Wiktionary gives "The place of intersection where one roll touches
      # another" for *nip*
      "&": %i[common conjunction fay cross intermix junction nip shared],
      # Disjunction with +other_array+
      # Wiktionary gives "To join or commit to, more or less permanently, as
      # if in marriage" for *wed*.
      "|": %i[twain disjunction conglomerate unit ambimix synthesis wed whole],
      # Disjunction with +other_arrays+
      # Wiktionary gives "To form a thick, tangled mess; to interweave into, or
      # like, a mat; to entangle" for *mat*.
      # Merriam-Webster gives "a gathering of people for a specific purpose" for
      # *bee*.
      union: %i[ally bee commingle entangle entwine intermingle intertwine
                interweave mat commix],
      # Merriam-Webster gives the following relevant definition for *din*
      # - to impress by insistent repetition
      # Wiktionary gives "To make a copy from an original or master audio tape"
      # for *dub*.
      "*": %i[autoecholalia autofuse autoloop dub din echo endomix replicate
              repeat scale selfappend selfconcatenate selfduplicate
              selfexalt selfinsert selfpush selfreplicate],
      # Supplement preservingly +self+ with entries from +other_array+
      # Return the still unasigned result
      "+": %i[add bemix couple fuse plus],

      # Supplement changingly +self+ at +index+ with +objects+ .
      # Return +self+
      # Wiktionary gives "To put into a sack" for *bag*.
      # Wiktionary gives "To place inside a box; to pack in one or more boxes"
      # for *box*.
      insert: %i[bag box mixin],
      # Supplement changingly +self+ at forefront with +objects+.
      # Return +self+
      # Note that +prepend+ is already an alias
      # Wiktionary gives "To put a bridle upon; to put the bit in the mouth of
      # (a horse)" for *bit*.
      unshift: %i[bit spill prepose underlay foremix],

      # Supplement changingly +self+ with entries from +other_object+
      # Note that +other_object+ is incorporated as a single element, even if
      # it is another Array.
      # Return +self+
      #
      # Wiktionary gives "To drain, suck or absorb from (tree, etc.)" for
      # *sap*. It also gives "To drink heartily; to tipple" for *bib*, but it's
      # considered here better to let it unused in this sense so *bib* can be
      # employed as a short synonym of identifier, refering to it as noun with
      # sense "A rectangular piece of material, carrying a bib number,
      # worn as identification by entrants in a race."
      #
      # Wiktionary gives "To fasten or attach (something) with a pin" for *pin*.
      "<<": %i[absorb assimilate blend immix incorporate mix pin sap],
      # Supplement changingly +self+ with entries from +*other_objects+
      # Return +self+
      # Note that +append+ is already an alias
      # Wiktionary gives "To place into a metal can (ie. a tin; be it tin,
      # steel, aluminum) in order to preserve" for *tin*,
      # Wiktionary gives "To put a lid on (something)" for *lid*.
      # Wiktionary gives "To graft by inserting a bud under the bark of another
      # tree" for *bud*.
      push: %i[affix admix annex attach bud fasten hang lid pile postpose suffix
               tin],
      # Supplement changingly +self+ with entries from +*other_arrays+
      # Return +self+
      # Wiktionary gives "to enclose by sewing" for *sew*.
      concat: %i[chain concatenate infuse
                 epimix integrate intermingle sew],

      # Withdraw preservingly elements from +self+ which are not present in
      # +other_array+
      # Return the still unasigned result
      "-": %i[deduct mow minus part substract unmix withhold],
      # Withdraw preservingly elements from +self+ which are not present in any
      # +other_arrays+
      # Return the still unasigned result
      difference: %i[bar exomix omit without],
      pop: %i[outmix],
      map: %i[transmix],
      map!: %i[transmix!],
      shift: %i[ebb mixoff],
      # Merriam-Webster gives "to make compact (as by pounding)" for *ram*.
      compact: %i[cram lop prune psycnomix ram],
      compact!: %i[cram! lop! prune! psycnomix!],
      delete: %i[ban exclude demix],
      delete_at: %i[off demixin],
      delete_if: %i[demixupon dismiss out past rid],
      # Wiktionary gives "(mining) To sort or separate, as ore in a jigger or
      # sieve" for *jig*.
      # Wiktionary give "(mining) To wash or cleanse, as a small portion of ore,
      # on a shovel" for *van*.
      # Note that +filter+ is already an alias
      select: %i[jig only solely van],
      select!: %i[jig! only! solely! van!],
      reject: %i[albeit but],
      reject!: %i[albeit! but!],
      keep_if: %i[hold on under mixupon],

      # Merriam-Webster gives "see *pair*" for *duo* and "two similar or
      # associated things" for pair.
      assoc: %i[associate duo pair],
      # Wiktionary gives "To be equivalent to in value" for buy
      #
      # Wiktionary gives "To look for, seek; to probe; to examine; to try; to
      # put to the test" for *woo*.
      rassoc: %i[buy right_associate first_pair_with_value woo],

      # Note that +String#split+ is also aliased to +cut+. Slide and split are
      # both synonym with divide in English, but only +String#split+ is defined
      # as alias of +#/+ in ruby.
      slice!: %i[carve cleave cut divide sever slit],
      # Wiktionary gives "To chop away at; to whittle down; to mow down" for
      # *hew*.
      # Wiktionary gives "To lay off, terminate or drastically reduce,
      # especially in a rough or ruthless manner; to cancel" for *axe*.
      uniq: %i[axe basics compounds constituents elements hew onesomes
               singularize sleek slick smooth streamline lonelify lowmix unite
               uniquify],
      uniq!: %i[axe! basics! compounds! constituents! elements! hew! onesomes!
                singularize! sleek! slick! smooth! streamline! lonelify! lowmix!
                unite! uniquify!],
      # Wiktionary gives "To remove or destroy the most important parts of" for
      # *gut*.
      # Wiktionary gives "To empty or pour" for *ent*.
      clear: %i[ent erase gut],

      # Wiktionary gives "To make a mess of something" for *bog*.
      shuffle: %i[bog remix],

      # Wiktionary gives "To join or fit together; to unite." for pan
      # Note that previous aliases which supplement elements all voluntarily
      # avoided to use words which encompasses the term *join[t]*, including
      # underjoin, subjoin, interjoin, anitjoin, autojoin, abjoin, disjoin,
      # injoint, and the like.
      #
      # Merriam-Webster gives "to extend out, up, or forward" for *jut*
      join: %i[assemble agglutinate coalesce conflate clip jut juxtapose meld
               pan mixdown weld],
      max: %i[maximum top],
      # Wiktionary gives "The bottom of a body of water, such as an ocean, sea,
      # lake, or river" for *bed".
      # Wiktionary gives "The bottom part of something" for *pit*.
      min: %i[bed pit minimun],
      # Merriam-Webster gives "to serve as a rim for" for *rim*.
      # Merriam-Webster gives "to surround in a restrictive manner" for *hem*.
      minmax: %i[boundaries brink extrema hem rim utmosts verge],
      # Wiktionary gives "A U-turn" for *uey*, itself defined as "A reversal of
      # policy; an about-face, a backflip".
      reverse: %i[retromix uey],
      reverse!: %i[retromix! uey!],
      # Wiktionary gives "To get something stuck in a confined space" for *jam*.
      pack: %i[jam],
      eql?: Kernel::INSTANCE_METHOD_ALIASES[:eql?],
      # woo/who
      # Wiktionary gives "To clumsily dig through something" for *paw*
      bsearch: %i[binary_search binary_chop excavate half_interval_search
                  logarithmic_search paw rummage],
      # Wiktionary gives "blame for something" for *rap*.
      bsearch_index: %i[binary_search_index binary_chop_index blame disclose
                        half_interval_search_index logarithmic_search_index rap
                        sleuth],
      rindex: %i[latest ultimate lag nut],
      to_ary: %i[raw]
    }.freeze
  end

  module BasicObject
    INSTANCE_METHOD_ALIASES = {
      # Wiktionary gives "Equal value; equality of nominal and actual value; the
      # value expressed on the face or in the words of a certificate of value,
      # as a bond or other commercial paper" for *par*.
      "==": %i[apt? congruent? equipotent? equiquantal? equivalue? par? worth?],
      # Wiktionary gives "To indicate or ascribe an attribute to" for *peg*.
      equal?: %i[equireferent? peg? univocal?],
      "!=": %i[inæqual? inequal? unequal? unlike? wry?],
      "!": %i[bad? con? negative? ko?],
      __id__: %i[badge bib emblem identifier insigne insignia],
      __send__: %i[address fax pst transmit],
      instance_eval: %i[contextually so tho wis],
      instance_exec: %i[pat plumb suitably],
      method_missing: %i[gap lake vacant on_vacancy way_off],
      singleton_method_added: %i[hail hey hi on_attachment],
      singleton_method_removed: %i[bye ciao leave_taking on_detachment],
      singleton_method_undefined: %i[farewell huh on_unattachment]
    }.freeze
  end

  module Comparable
    INSTANCE_METHOD_ALIASES = {
      # Wiktionary gives "Before; sooner than." for *ere*
      "<": %i[afore? ahead? antecede? before? ere? inferior_to? less_than?
              lower_than? prior? subcede? subceed? smaller_than? precede?],
      # Wiktionary gives "Inner, interior" as well as "Inside" for *ben*
      "<=": %i[at_most? behind? ben? below? beneath? comprised? proconcede?
               under? underneath? within?],
      # Wiktionary gives "Equal to or fulfilling some requirement" for *apt*.
      "==": %i[apt? concede?], # also has other aliases through BasicObject
      # Wiktionary gives "Alternative form of umbe, around, about; after" for
      # *um*.
      #
      # Merriam-Webster gives "an upper limit (as on expenditures) : ceiling"
      # for *cap*.
      ">=": %i[above? accede? at_least? cap? comprise? onward?
               prosupercede? um? umbe? upward? upon?],
      # Wiktionary gives "Acting as or as if being located at a higher rank" and
      # "To excel; to rise above others" for *top*.
      #
      # Wiktionary gives "To clear (a hurdle, high jump bar, etc.) by a large
      # margin" for *sky*.
      ">": %i[after? beyond? excede? exceed? greater_than? higher_than? over?
              outdo? outstrip? postcede? sky? supercede? supersede? superior_to?
              top? upper_than?]
    }.freeze
  end

  module Dir
    SINGLETON_METHOD_ALIASES = {
      # Wiktionary gives "To encircle; to surround; to enclose" for *orb*.
      "[]": %i[conform native_global_match orb suit]
    }.freeze
  end

  # @see TrueClass
  # @see NilClass
  module FalseClass
    INSTANCE_METHOD_ALIASES = {
      # Wiktionary gives "Also; in addition to." for *eke*.
      "&": %i[also and conjunction eke],
      "|": %i[or inclusive_disjunction],
      "^": %i[ban nay exclusive_disjunction]
    }.freeze
  end

  module TrueClass
    INSTANCE_METHOD_ALIASES = FalseClass::INSTANCE_METHOD_ALIASES
  end

  module Enumerable
    INSTANCE_METHOD_ALIASES = {
      # Wiktionary gives "(slang, UK) To give someone an injection" for *jab*
      inject: %i[jab],
      # Note that +collect_concat+ is already an alias
      # Wiktionary gives "To gather into a lump" for *gob*.
      flat_map: %i[gob]
    }.freeze
  end

  module Enumerator
    # List of aliases provided for each class method indexed by its identifier
    INSTANCE_METHOD_ALIASES = {
      "+": Array::INSTANCE_METHOD_ALIASES[:+]
    }.freeze
  end

  module Range
    INSTANCE_METHOD_ALIASES = {
      # Standard library already define +step+ as synonym of +%+.
      # Wiktionary provides the following definition for *bar*:
      # - A prescribed quantity or extent; moderation, temperance.
      # - Any level of achievement regarded as a challenge to be overcome.
      #
      # Merriam-Webster gives the following definition for *hop*
      # - to move by a quick springy leap or in a series of leaps
      # and the following for *pas*
      # - a dance step or combination of steps
      "%": %i[hop pas]
    }.freeze
  end

  module Numeric
    INSTANCE_METHOD_ALIASES = {
      # Regarding lap, Merriam-Webster gives the following relevant definitions:
      # - to overtake and thereby lead or increase the lead over (another
      #   contestant) by a full circuit of a racecourse
      # - to complete the circuit of (a racecourse)
      # - to project beyond or spread over something
      #
      # That seems a good fit to provide a shorter term than *modulo* without
      # resorting on an apocope like *mod*.
      "%": %i[lap],
      # Merriam-Webster gives "to acknowledge something to be true, valid, or
      # as claimed" for *own*.
      "+@": %i[substractive_inverse aver avow identity insist own vow],

      # Wiktionary gives "To rival (something), etc." for *vie*.
      "-@": %i[additive_inverse negation opposite sign_change vie]

    }.freeze
  end

  module Arithmophore
    INSTANCE_METHOD_ALIASES = {
      "+": %i[add append plus supplement],
      # Regarding *mow*, Merriam-Webster provides the following relavant definition:
      # - to cut down with a scythe or sickle or machine
      # Regarding *lop*:
      # a : to remove superfluous parts from
      # b : to eliminate as unnecessary or undesirable
      "-": %i[deduct minus lop mow remove subtract],
      # Note that *ex* is an alternative pronounciation of the more frequent
      # *times* as pronounciation of the cross multiplication symbol, <tt>×</tt>
      # whose glyph is close to a ex latin letter <tt>x</tt>.
      #
      # In the same vein, *dot* refers to the mid-line dot symbol <tt>⋅</tt>
      # also commonly employed as a mean to denote multiplication.
      #
      # Of course in Ruby, +#times+ is already used to create loops.
      # This is why a specific overload of this method is required to make the
      # identifier callable in both cases.
      #
      "*": %i[cross dot ex multiply],
      # Regarding cut, Merriam-Webster provides the following relavant definition:
      # - to divide into shares : split
      "/": %i[cut divide split],
      # Vis:
      #     Force; energy; might; power.
      # Wax:
      # a : to increase in size, numbers, strength, prosperity, or intensity
      # b : to grow in volume or duration
      # c : to grow toward full development
      "**": %i[exponent power raised_to_the_power to_the vis wax weighted]
    }.freeze
  end

  module Complex; INSTANCE_METHOD_ALIASES = Arithmophore::INSTANCE_METHOD_ALIASES end
  module Float; INSTANCE_METHOD_ALIASES = Arithmophore::INSTANCE_METHOD_ALIASES end
  module Rational; INSTANCE_METHOD_ALIASES = Arithmophore::INSTANCE_METHOD_ALIASES end

  module Integer
    # Recuperate entries from Arithmophore in a anfrozen copy and add new items
    # before frozing the result again.
    INSTANCE_METHOD_ALIASES = Arithmophore::INSTANCE_METHOD_ALIASES.dup.tap do |kin|
      # Wiktionary gives "To assemble" as well as "To bring together; join
      # (in marriage, friendship, love, etc.)" for *sam*.
      # Wiktionary gives "To weld together through a series of connecting or
      # overlapping spot welds" for "sew".
      kin.store(:|, %i[bitwise_inclusive_disjunction sam sew])
      # Although *bar* is somehow in dissonance with the association to
      # *caret* rather than with *vertical bar*, it is more relevant regarding
      # its exclusionary semantic. Note that this also voluntarily avoid a
      # lexical conflict with *ban* used as alias for the logical exclusive
      # disjunction operator.
      kin.store(:^, %i[bar bitwise_exclusive_disjunction])
      # Merriam-Webster gives "to become tipped : topple" as well as
      # "to shift the balance of power or influence" for *tip*.
      # Still for *tip*, Wiktionary gives "to become knocked over, fall down
      # or overturn".
      # Merriam-Webster gives "alternate" for *yaw*.
      # Wiktionary gives "To move with a sharp turn or reversal" as well as
      # "twist in a storyline" for *zag*.
      kin.store(:~, %i[antipole antipode bitwise_complement bitwise_negation
                       bitwise_one_s_complement complement not
                       one_s_complement tip yaw zag])
      # Wiktionary gives "To join or fit together; to unite" for *pan*.
      kin.store(:&, %i[bitwise_conjonction join pan])

      # Wiktionary gives "To turn towards the driver, typically to the left" for
      # *haw*.
      # Merriam-Webster gives "to turn to the near or left side" for *haw*.
      kin.store(:<<, %i[haw left_arithmetic_shift])

      # Merriam-Webster gives "to turn to the right side" for *gee*.
      kin.store(:>>, %i[gee right_arithmetic_shift])

      # Returns a string containing the character associated with self integer
      # value in a given +encoding+ or in the interpreter default one.
      #
      # Merriam-Webster gives "outward appearance of a thing" for *air*.
      # Merriam-Webster gives "recognize" for *ken*.
      # Wiktionary gives "To know, perceive or understand" and "To discover by
      # sight; to catch sight of; to descry" for *ken*.
      #
      # @see String#chr
      kin.store(:chr, %i[air character ken recognize reconnoitre])
    end.freeze
  end

  module Mutex
    # List of aliases provided for each instance method indexed by its identifier
    INSTANCE_METHOD_ALIASES = {
      # Wiktionary gives "To shut away, confine, lock up" for *mew*.
      lock: %i[mew]
    }.freeze
  end

  # Module which contains several groups of functionality for handling OS
  # processes.
  module Process; end

  module Process
    module Status
      # List of aliases provided for each instance method indexed by its identifier
      INSTANCE_METHOD_ALIASES = {
        "&": Integer::INSTANCE_METHOD_ALIASES[:&],
        ">>": Integer::INSTANCE_METHOD_ALIASES[:>>]
      }.freeze
    end
  end

  # Holds Integer values.
  class ::Integer
    alias times_loop times

    # If a single argument is given, performs multiplication between +self+ and
    # this argument, otherwise loop +self+-times over the passed block otherwise.
    def times(*fad, &block)
      return (self * fad.first) if fad.size == 1

      times_loop(*fad, &block)
    end
  end

  # Bidimensionnal float number
  class ::Complex; alias times *; end
  # Float objects represent inexact real numbers using the native architecture's
  # double-precision floating point representation.$
  class ::Float; alias times *; end
  # A rational number can be represented as a pair of integer numbers: a/b (b>0),
  # where a is the numerator and b is the denominator. Integer a equals rational
  # a/1 mathematically.
  class ::Rational; alias times *; end

  # @see NilClass
  module Regexp
    # List of aliases provided for each instance method indexed by its identifier
    INSTANCE_METHOD_ALIASES = {
      "=~": %i[hit index_of_first_matching],
      # As a reminder the tilde implicitely match against +$LAST_READ_LINE+
      # (aka +$_+).
      #
      # Ruby allows to call it both in suffixed and prefixed form, that is
      # +some_regexp.~+ and +~some_regexp+.
      #
      # Note that these aliases cover only the case of a method call suffixing a
      # Regexp object, like +some_regexp.index_of_first_hot_matching+. For a
      # prefixed method expression form, see +Englishest#spot+.
      "~": %i[hit_tacitely index_of_first_hot_matching hot
              index_of_first_matching_on_last_read_line]
    }.freeze
  end

  # @see FalseClass
  # @see TrueClass
  # @see Regexp
  module NilClass
    INSTANCE_METHOD_ALIASES = FalseClass::INSTANCE_METHOD_ALIASES.dup.tap do |kin|
      kin.store(:=~, Regexp::INSTANCE_METHOD_ALIASES[:=~])
    end.freeze
  end

  module String
    INSTANCE_METHOD_ALIASES = {

      # Returns the Integer index of the first substring that matches the given
      # regexp, or nil if no match found:
      "=~": Regexp::INSTANCE_METHOD_ALIASES[:=~],

      # Returns the result of formatting  into the format specification self
      # (see Kernel#sprintf for formatting details):
      #
      # Merriam-Webster gives "to produce or form by cutting with a saw" for
      # *saw*.
      #
      # Wiktionary gives "The mold in which a block of metal is cast" for *pig*.
      "%": %i[form format form mold pig saw shape],

      # Merriam-Webster gives the following relevant definition for *din*
      # - to impress by insistent repetition
      # Wiktionary gives "To make a copy from an original or master audio tape"
      # for *dub*.
      "*": %i[autoecholalia din dub echo replicate repeat],
      # Note that +#/+ is actually an alias of +#split+.
      "/": %i[cut divide disjoin],
      "+": %i[add append attach couple juxtapose plus suffix],
      "<<": %i[admix mix pin],
      concat: Array::INSTANCE_METHOD_ALIASES[:concat],
      prepend: Array::INSTANCE_METHOD_ALIASES[:unshift],
      # Merriam-Webster gives "to give a permanent or final form to" for *fix*
      "-@": %i[fix immutable inalterable unalterable],
      # Return +self+ unless it's frozen, thereof the unfrozen +self.dup+ is
      # returned
      #
      # Wiktionary gives "To bend, to flex; to be bent by something, to give way
      # or yield (to a force, etc.)" for *ply*.
      "+@": %i[alterable changeable fickle mutable ply versatile],

      "[]": Array::INSTANCE_METHOD_ALIASES[:[]],
      "[]=": Array::INSTANCE_METHOD_ALIASES[:[]=],
      # Returns a copied string whose encoding is ASCII-8BIT.
      # +#b+ stands for binary, see https://bugs.ruby-lang.org/issues/10924
      # Indeed Encoding::BINARY is an alias for Encoding::ASCII-8BIT
      b: %i[ASCII ascii binary retrograde low vulgar],
      # Wiktionary gives "To be, or be like, a twin to (someone else); to match
      # in some way" for *twin*.
      #
      # Wiktionary gives "To bring into relation; establish a relationship
      # between; make friendly; reconcile" for *sib*.
      casecmp: %i[equate look_alike homeotetrachotomize link liken
                  relate sib twin],
      casecmp?: %i[equate? look_alike? homeotetrachotomize? link?
                   liken? relate? sib? twin?],
      # Returns a string with the first character of a non-empty string or the
      # empty string
      #
      # see Integer#chr
      chr: Integer::INSTANCE_METHOD_ALIASES[:chr] + %i[glance initial],
      # Wiktionary gives "To deprive of distinct vision; to hinder from seeing
      # clearly, either by dazzling or clouding the eyes; to darken the senses
      # or understanding of" for *dim*.
      crypt: %i[curtain dim encrypt],
      # Wiktionary gives "To sip; to take a small amount of food or drink into
      # the mouth, especially with a spoon" for *sup*.
      each_char: %i[each_character sup],
      # Wiktionary gives "To take the place of" for *sit*.
      replace: %i[sit],
      # Merriam-Webster gives "within" for *ben*.
      # Wiktionary gives "Inner, interior" and "Inside" for *ben*.
      # Wiktionary gives "To weigh; to yield in tods" for *tod*".
      getbyte: %i[ben octet tod],
      # Wiktionary gives "To graft or implant (something other than a plant); to
      # fix or set (something) in" for *imp*.
      #
      # Wiktionary gives "To graft by inserting a bud under the bark of another
      # tree" and "To put forth as a bud" for *bud*.
      sub: %i[alter bud imp infuse substitute suffuse swop],
      sub!: %i[alter! imp! infuse! substitute! suffuse! swop!],
      # Webster-Merriam gives "to wet thoroughly with liquid" for *sop*
      gsub: %i[diffuse imbue transfuse pansubstitute pervade riddle sop
               globally_substitute steep],
      gsub!: %i[diffuse! imbue! transfuse! pansubstitute! pervade! riddle! sop!
                globally_substitute! steep!],
      # XVI is the Roman numeral representing the number sixteen
      # Wiktionary gives "A unit of mass equal to 16 avoirdupois ounces"
      # "To confine in, or as in, a pound; to impound"
      hex: %i[hexadecimalize pud sexadecimalize XVI xvi pound],
      # Wiktionary gives "To stuff" for *pad*.
      ljust: %i[pad left_justify],
      # Wiktionary gives "To create a hollow indentation" for *dap*.
      # Incidently its also the reversed letter of *pad* used as alias for the
      # inverse operation.
      rjust: %i[dap right_justify],

      # Wiktionary gives "To rise or flow up to or over the edge of something"
      # for *lip*.
      lstrip: %i[lip],
      # Wiktionary gives "To cut off as the top or extreme part of anything,
      # especially to prune a small limb off a shrub or tree, or sometimes to
      # behead someone" for *lop*.
      #
      # Merriam-Webster gives "to tear or split apart or open" for *rip*
      rstrip: %i[lop rip],
      # Wiktionary gives "To polish, e.g., a surface, until smooth" for *lap*
      #
      # Wiktionary gives "To perform the action of plunging a dipper, ladle.
      # etc. into a liquid or soft substance and removing a part" for *dip*
      #
      # Wiktionary gives "To remove by pinching, biting, or cutting with two
      # meeting edges of anything; to clip" for *nip*.
      strip: %i[lap dip nip],

      # Many bees build octogonal hives, so let's say that "to bee" might be
      # used as a verb meaning "To build an octonary structure".
      oct: %i[bee octalize],

      # Wiktionary gives "A rectangular piece of material, carrying a bib
      # number, worn as identification by entrants in a race" for *bib*.
      ord: %i[bib ordinal_numeral ordinalize],

      # Merriam-Webster gives "an often small and temporary dwelling of simple
      # construction", for *hut*,  so here taken as a metonymy for the location
      # where one shelter. It also morpohologically coordinates with *hit* and
      # *hot* aliasing similar methods elsewhere.
      #
      # @see Kernel#=~
      # @see Regexp#=~
      # @see Regexp#~
      # @see String#=~
      index: %i[hut],
      # Merriam-Webster gives "one that lags or is last" for *lag*.
      # Merriam-Webster gives "to gather or seek nuts" for "nut".
      rindex: %i[latest ultimate lag nut],

      # Wiktionary gives "To cut unevenly." for *jag*.
      partition: %i[jag],
      # Wiktionary gives "To cut or dress roughly, as a grindstone" for *rag*
      rpartition: %i[retropartition rag],

      # continue
      # grow
      # next
      #
      # Merriam-Webster gives "to bend upward —used especially of the edge of a
      # plank near the bow or stern of a ship" for *sny*.
      succ: %i[successor sny],
      succ!: %i[successor! sny!],
      # Wiktionary gives "To blend (wines or spirits) in a vat; figuratively,
      # to mix or blend elements as if with wines or spirits" for *vat*.
      # Wiktionary gives "To make incline, deviate, or bend, from an initial
      # position" for *bow*.
      tr: %i[bow translate vat],
      tr!: %i[bow! translate! vat!],
      # Note that the base name comes from the flagged Unix command `tr -s`.
      tr_s: %i[translate_squeeze_repeats],

      # Wiktionary gives "To free or liberate from confinement or other physical
      # restraint, to recover forcibly" for *rid*.
      unpack: %i[rid],
      # Wiktionary gives "To take out the entrails of (herrings)" for *gip*.
      unpack1: %i[gip]
    }.freeze
  end

  module SystemCallError
    # List of aliases provided for each class method indexed by its identifier
    SINGLETON_METHOD_ALIASES = {
      "===": %i[encompass? fit? gird?]
    }.freeze
  end

  module Hash
    # List of aliases provided for each class method indexed by its identifier
    SINGLETON_METHOD_ALIASES = {
      # create a new instance encompassing parameters
      "[]": %i[create engender generate gig]
    }.freeze
    INSTANCE_METHOD_ALIASES = {
      # Wiktionary gives "A small section of a larger office, compartmentalised
      # for a specific purpose" and "A subsection of a prison, containing a number of
      # inmates" for *pod*
      #
      # Wiktionary gives "to inhabit; occupy" for *big*.
      #
      # Wiktionary gives "To ensconce or hide oneself in (or as in) a den", that
      # is "a small cavern or hollow place in the side of a hill, or among
      # rocks" for *den*.
      "<": %i[big? den? pod? proper_subset?],
      # Wiktionary gives "Inner, interior" as well as "Inside" for *ben*
      "<=": %i[ben? subset?],
      # Wiktionary gives "To enclose in a pen", that is "An enclosure
      # (enclosed area)" for *pen*.
      ">": %i[pen? proper_superset?],
      # Merriam-Webster gives "an upper limit (as on expenditures) : ceiling"
      # for *cap*.
      ">=": %i[cap? comprise? superset?],
      # overriding the inherited method pointers
      "==": %i[apt? congruent? equipotent? equiquantal? equivalue? par? worth?],
      "[]": Array::INSTANCE_METHOD_ALIASES[:[]],
      "[]=": Array::INSTANCE_METHOD_ALIASES[:[]=],
      # Merriam-Webster gives "see *pair*" for *duo* and "two similar or
      # associated things" for pair.
      assoc: Array::INSTANCE_METHOD_ALIASES[:assoc],
      # Wiktionary gives "To be equivalent to in value" for buy
      #
      # Wiktionary gives "To look for, seek; to probe; to examine; to try; to
      # put to the test" for *woo*.
      rassoc: Array::INSTANCE_METHOD_ALIASES[:rassoc],
      eql?: Kernel::INSTANCE_METHOD_ALIASES[:eql?]
    }.freeze
  end

  module Module
    # List of aliases provided for each instance method indexed by its identifier
    INSTANCE_METHOD_ALIASES = {
      "<": %i[subclass?] + Hash::INSTANCE_METHOD_ALIASES[:<],
      "<=": %i[based_on? of?] + Hash::INSTANCE_METHOD_ALIASES[:<=],
      ">": %i[superclass?] + Hash::INSTANCE_METHOD_ALIASES[:<],
      ">=": %i[ground?] + Hash::INSTANCE_METHOD_ALIASES[:<]
    }.freeze
  end

  module IO
    # List of aliases provided for each class method indexed by its identifier
    INSTANCE_METHOD_ALIASES = {
      "<<": Array::INSTANCE_METHOD_ALIASES[:<<]
    }.freeze
  end

  module Time
    # List of aliases provided for each class method indexed by its identifier
    INSTANCE_METHOD_ALIASES = {
      "<=>": Kernel::INSTANCE_METHOD_ALIASES[:<=>],
      "+": Integer::INSTANCE_METHOD_ALIASES[:+],
      "-": Integer::INSTANCE_METHOD_ALIASES[:-]
    }.freeze
  end

  module Warning
    # List of aliases provided for each class method indexed by its identifier
    SINGLETON_METHOD_ALIASES = {
      "[]=": %i[lay in],
      "[]": %i[at of]
    }.freeze
  end

  # This make the bulk of the work of actually setting aliases, using
  # constants in submodules of Englishest
  covered_types.each do |type|
    Object.const_get("::#{type}").class_eval do
      # Define aliases of instance methods if such a list is provided
      begin
        Object.const_get("::Englishest::#{self}::INSTANCE_METHOD_ALIASES").each do |operator, monikers|
          # Somehow dirty, but Complex#% is not defined in the standard library
          # so this avoids to raise a NameError and dismiss all aliases copied
          # from Numeric.
          next if to_s == "Complex" && operator == :%

          monikers.each { alias_method _1, operator }
        end
      rescue NameError
        # No instance method defined for this class, it's fine.
      end

      # Define aliases of singleton methods if such a list is provided
      begin
        class << self
          aim = "::Englishest::#{to_s.split(":").last.chomp(">")}::SINGLETON_METHOD_ALIASES"
          Object.const_get(aim).each do |operator, monikers|
            monikers.each { alias_method _1, operator }
          end
        end
      rescue NameError
        # No singleton/instance method defined for this class, it's fine.
      end
    end
  end

  # Remove Comparable methods from Complex, to align with what the standard
  # library does, and overload +Comparable#==+ with +Complex#==+, to avoid
  # erroneous results.
  #
  # See https://stackoverflow.com/q/72314247/1307778
  class ::Complex
    Comparable::INSTANCE_METHOD_ALIASES.each do |operator, monikers|
      if operator == :==
        monikers.each { alias_method _1, operator }
      else
        monikers.each { undef_method _1 }
      end
    end
  end
end

# Provide synonyms for some classes
Duction = IO unless (defined? Duction) == "constant"
Lug = IO unless (defined? Lug) == "constant"
