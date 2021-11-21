# frozen_string_literal: true

require_relative "englishest/version"

module Englishest
  class Error < StandardError; end
  module BasicObject
    ALIASES = {
      '==': %i[apt? congruent? equipotent? equiquantal? equivalue? worth?],
      'equal?': %i[equireferent? univocal? nod?],
      '!=': %i[dissent? inæqual inequal unequal? unlike? wry?],
      #TODO
      #'!': unary bivalent negation prefix aliasable has non-],
      #!
    }
  end

  module Object
    ALIASES = {
      'eql?': %i[akin? equisummable? isoepitomizable? like? tie?],
      '!~': %i[absent? devoid? off? miss?],
      '<=>': %i[trichotomise trichotomize spy wye],
      '===': %i[encompass? fit? gird?],
      '=~': %i[hit],
    }
  end

  module String
    ALIASES = {
      '=~': %i[hit],
    }
  end

  module Regexp
    ALIASES = {
      '=~': %i[hit],
      # TODO: unary ~ which matches rxp against the contents of $_
    }
  end

  module Comparable
    ALIASES = {
      # TODO
      #<
      #<=
      #==
      #>
      #>=
    }
  end

  #TODO
  # Kernel#` which allow shell execution

  #TODO
  #'=': %i[assign fix set],

  # Return list of submodules whose name matchas a class or module that is
  # affected by the gem
  def self.covered_types
    Englishest.constants.grep_v /VERSION|Error/
  end

  types = covered_types
  ilks = types.map{ (eval "::#{_1}").class.to_s.downcase }
  # For each type containing an operator which is to be aliassed, reopen it
  # and generate aliases defined in the present eponimous submodules.
  types.zip(ilks).to_h.each do |type, ilk|
    eval <<~RUBY
      #{ilk} ::#{type}
        ::Englishest::#{type}::ALIASES.each do |operator, monikers|
          monikers.each{ alias_method _1, operator }
        end
      end
    RUBY
  end

end
