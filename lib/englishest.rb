# frozen_string_literal: true

require_relative "englishest/version"

module Englishest
  class Error < StandardError; end

  class Comparable
    # Albionian rendition
    alias_method :trichotomise, :<=>
    # Yankee version
    alias_method :trichotomize, :<=>
  end
end
