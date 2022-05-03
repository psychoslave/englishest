# frozen_string_literal: true

require_relative "englishest/version"
require "English"

# Encapsulate all the contrivances to allow a coding style using more English
# vocabulary, especially enabling to express ideas without ideographi operators.
module Englishest
  # Class usable to throw errors specifically related to the Englishest module.
  class Error < StandardError; end

  # Return list of submodules whose name matches a class or module that is
  # affected by the gem
  def self.covered_types
    Englishest.constants.grep_v(/VERSION|Error/)
  end

  # Object is the default root of all Ruby objects.
  # Methods on Object are available to all classes unless explicitly overridden.
  #
  # Only two instance methods related to +equal?+ are added here, as well as
  # a global method to replace the +~+ unary prefix matching operator.
  class ::Object
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
    # Note that +axe?+, +ban?+, +nay?+, +nix?+ and +ort?+ have also been
    # considered, but were reserved for other uses or dismissed as too uncommon
    # Cambridge dictionary gives "to stop, prevent, or refuse to accept
    # something" for *nix*.
    alias nix? dissent?

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
      "|": %i[twain disjunction duo conglomerate unit ambimix synthesis wed whole],
      # Disjunction with +other_arrays+
      # Wiktionary gives "To form a thick, tangled mess; to interweave into, or
      # like, a mat; to entangle" for *mat*.
      # Merriam-Webster gives "a gathering of people for a specific purpose" for
      # *bee*.
      union: %i[ally bee commingle entangle entwine intermingle intertwine
                interweave mat panmix],
      # Merriam-Webster gives the following relevant definition for *din*
      # - to impress by insistent repetition
      # Wiktionary gives "To make a copy from an original or master audio tape"
      # for *dub*.
      "*": %i[autoecholalia autofuse autoloop dub din echo endomix replicate
              repeat scale selfappend selfconcatenate selfduplicate
              selfexalt selfinsert selfpush selfreplicate],
      # Supplement preservingly +self+ with entries from +other_array+
      # Return the still unasigned result
      "+": %i[add bemix fuse plus],

      # Supplement changingly +self+ at +index+ with +objects+ .
      # Return +self+
      # Wiktionary gives "To put into a sack" for *bag*.
      # Wiktionary gives "To place inside a box; to pack in one or more boxes"
      # for *box*.
      insert: %i[bag box mixin],
      # Supplement changingly +self+ at forefront with +objects+.
      # Return +self+
      # Note that +prepend+ is already an alias
      unshift: %i[spill tip foremix],

      # Supplement changingly +self+ with entries from +other_object+
      # Note that +other_object+ is incorporated as a single element, even if
      # it is another Array.
      # Return +self+
      # Wikitionary gives "To drain, suck or absorb from (tree, etc.)" for
      # *sap*. It also gives "To drink heartily; to tipple" for *bib*, but it's
      # considered here better to let it unused in this sense so *bib* can be
      # employed as a short synonym of identifier, refering to it as noun with
      # sense "A rectangular piece of material, carrying a bib number,
      # worn as identification by entrants in a race."
      "<<": %i[absorb assimilate blend immix incorporate mix sap],
      # Supplement changingly +self+ with entries from +*other_objects+
      # Return +self+
      # Note that +append+ is already an alias
      # Wiktionary gives "To place into a metal can (ie. a tin; be it tin,
      # steel, aluminum) in order to preserve" for *tin*,
      # Wiktionary gives "To put a lid on (something)" for *lid*.
      # Merriam-Webster gives "affix, attach" for *fix*.
      push: %i[affix admix annex attach fasten hang fix lid suffix tin],
      # Supplement changingly +self+ with entries from +*other_arrays*
      # Return +self+
      # Wiktionary gives "to enclose by sewing" for *sew*.
      concat: %i[associate chain concatenate couple infuse
                 commix integrate intermingle sew],

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
      compact: %i[cram lop prune psycnomix],
      compact!: %i[cram! lop! prune! psycnomix!],
      delete: %i[ban exclude demix],
      delete_at: %i[off demixin],
      delete_if: %i[beyond demixupon dismiss out past rid],
      # Wiktionary gives "(mining) To sort or separate, as ore in a jigger or
      # sieve" for *jig*.
      # Note that +filter+ is already an alias
      select: %i[jig only solely],
      select!: %i[jig! only! solely!],
      reject: %i[albeit but],
      reject!: %i[albeit! but!],
      keep_if: %i[hold on under mixupon],
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
               unique],
      uniq!: %i[axe! basics! compounds! constituents! elements! hew! onesomes!
                singularize! sleek! slick! smooth! streamline! lonelify! lowmix!
                unite! unique!],
      clear: %i[gut],

      # Wiktionary gives "To make a mess of something" for *bog*.
      shuffle: %i[bog remix],

      # Wiktionary give "To join or fit together; to unite." for pan
      # Note that previous aliases which supplement elements all avoided to use
      # words which encompasses the term *join[t]*
      join: %i[assemble agglutinate coalesce conflate clip juxtapose meld pan
               mixdown weld]
    }.freeze
  end

  module BasicObject
    INSTANCE_METHOD_ALIASES = {
      "==": %i[apt? congruent? equipotent? equiquantal? equivalue? worth?],
      equal?: %i[equireferent? peg? univocal?],
      "!=": %i[inæqual? inequal? unequal? unlike? wry?],
      "!": %i[bad? con? negative? ko?],
      __id__: %i[badge bib emblem identifier insigne insignia],
      __send__: %i[address fax hop pst transmit],
      instance_eval: %i[contextually so tho wis],
      instance_exec: %i[aptly pat plumb suitably],
      method_missing: %i[gap lake vacant on_vacancy way_off],
      singleton_method_added: %i[hail hey hi on_attachment],
      singleton_method_removed: %i[bye ciao leave_taking on_detachment],
      singleton_method_undefined: %i[farewell huh on_unattachment]
    }.freeze
  end

  module Dir
    SINGLETON_METHOD_ALIASES = {
      # Wiktionary gives "To encircle; to surround; to enclose" for *orb*.
      "[]": %i[conform native_global_match orb suit]
    }.freeze
  end

  module Enumerable
    INSTANCE_METHOD_ALIASES = {
      # Wiktionary gives "(slang, UK) To give someone an injection" for *jab*
      inject: %i[jab]
    }.freeze
  end

  module Hash
    # List of aliases provided for each class method indexed by its identifier
    SINGLETON_METHOD_ALIASES = {
      # create a new instance encompassing parameters
      "[]": %i[create engender generate gig]
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
      "%": %i[bar hop pas]
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
      # Tip:
      #  1 : to register weight
      #  2 : to shift the balance of power or influence
      # Vis:
      #     Force; energy; might; power.
      # Wax:
      # a : to increase in size, numbers, strength, prosperity, or intensity
      # b : to grow in volume or duration
      # c : to grow toward full development
      "**": %i[exponent power raised_to_the_power to_the tip vis wax weighted]
    }.freeze
  end

  module Complex; INSTANCE_METHOD_ALIASES = Numeric::INSTANCE_METHOD_ALIASES end
  module Float; INSTANCE_METHOD_ALIASES = Numeric::INSTANCE_METHOD_ALIASES end
  module Integer; INSTANCE_METHOD_ALIASES = Numeric::INSTANCE_METHOD_ALIASES end
  module Rational; INSTANCE_METHOD_ALIASES = Numeric::INSTANCE_METHOD_ALIASES end

  # Holds Integer values.
  class ::Integer
    alias times_loop times

    # Synonym of +#*+ if a single argument is given, loop other n-times over the
    # passed block otherwise.
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

  module String
    INSTANCE_METHOD_ALIASES = {
      "=~": %i[hit index_of_first_matching],
      # Merriam-Webster gives the following relevant definition for *rim*
      # - to serve as a rim for
      # And for *fix*
      # - to give a permanent or final form to
      # And for *hem*
      # - to surround in a restrictive manner
      # And for *saw*
      # - to produce or form by cutting with a saw
      "%": %i[form format fix form hem shape rim saw],
      # Merriam-Webster gives the following relevant definition for *din*
      # - to impress by insistent repetition
      # Wiktionary gives "To make a copy from an original or master audio tape"
      # for *dub*.
      "*": %i[autoecholalia din dub echo replicate repeat]
    }.freeze
  end

  module SystemCallError
    # List of aliases provided for each class method indexed by its identifier
    SINGLETON_METHOD_ALIASES = {
      "===": %i[encompass? fit? gird?]
    }.freeze
  end

  module Comparable
    INSTANCE_METHOD_ALIASES = {
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
    INSTANCE_METHOD_ALIASES = {
      # Merriam-Webster gives "to provide or offer something equal to : equal"
      # for *tie*.
      eql?: %i[akin? equisummable? isoepitomizable? like? tie?],
      "!~": %i[absent? devoid? off? miss?],
      "===": %i[encompass? fit? gird?],
      "=~": %i[hit],
      "<=>": %i[trichotomise trichotomize spy wye],
      "`": %i[subshell run]
    }.freeze
  end

  module Warning
    # List of aliases provided for each class method indexed by its identifier
    SINGLETON_METHOD_ALIASES = {
      "[]=": %i[lay in],
      "[]": %i[at of]
    }.freeze
  end

  # This make the bulk of the work of actually setting aliases, using INSTANCE_METHOD_ALIASES
  # constant in submodules of Englishest
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
end
