# frozen_string_literal: true

require_relative "englishest/version"

module Englishest
  class Error < StandardError; end
  module Comparable
    ALIASES = {
      '<=>': %i[trichotomise trichotomize spy wye]
    }
  end


  module ::Comparable
    Englishest::Comparable::ALIASES.each do |operator, monikers|
      monikers.each{ alias_method _1, operator }
    end
  end
end
