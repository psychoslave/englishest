# frozen_string_literal: true

require_relative "englishest/version"

module Englishest
  class Error < StandardError; end
  Comparable_aliases = {
    '<=>': %i[trichotomise trichotomize spy wye]
  }


  module ::Comparable
    Englishest::Comparable_aliases.each do |operator, monikers|
      monikers.each{ alias_method _1, operator }
    end
  end
end
