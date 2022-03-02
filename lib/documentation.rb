class Dir
  ##
  # :singleton-method: []
  # Dir has a singleton method <tt>[](*args, base: nil, sort: true)</tt>
  # which is equivalent to call <tt>Dir.glob([string, ...], 0)</tt>
  #
  # The +0+ passed as last argument is a flag that indicates case sensitivity.
  # Given that +File::FNM_SYSCASE+ is defined as system default case
  # insensitiveness, equals to +FNM_CASEFOLD+ or 0, it means that the expansion
  # will match file name depending on how system consider case sensitivity.
  #
  # For information, FNM stands for "filename match". Indeed, from an historical
  # perspective, the +glob+ UNIX command is usually based on the +fnmatch+
  # function, which tests for whether a string matches a given pattern.
  #
  # In other word this method allows to access files matching the expansion of a
  # string including wildcard characters while using system case conformity.

  ##
  # :singleton-method: conform
  # Alias for +[]+ with alignment on semantic: a thing conforms to a set of
  # rules, with a norm or standard, that is a system.

  ##
  # :singleton-method: native_global_match
  # Alias for +[]+ with alignment on the original lexic

  ##
  # :singleton-method: orb
  # Alias for +[]+ with alignment on the notion of *global*, moreover as a
  # poetic singleton-metaphor, the verb means to encircle; to surround; to enclose.

  ##
  # :singleton-method: suit
  # Alias for +[]+ shorter synonym of conform, with the same justifying semantic.
end

