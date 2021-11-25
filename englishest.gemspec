# frozen_string_literal: true

require_relative "lib/englishest/version"

Gem::Specification.new do |spec|
  spec.name          = "englishest"
  spec.version       = Englishest::VERSION
  spec.authors       = ["Mathieu Lovato Stumpf Guntz"]
  spec.email         = ["psychoslave@culture-libre.org"]

  spec.summary       = "A Ruby gem which allows a more literate coding style"
  spec.description   = <<~ABOUT
    This gem aims to provides alternative ways to utter Ruby code, simply defining
    synonyms for miscellaneous terms, especially offering full word counterpart
    to ideograms/logograms such as the so called *spaceship operator*.

    The name of the gem is of course a pun: a library which provides ability
    to utter coder which is closer to a voiceable English obviously ought to do it
    so through an obvious transgression of this language usual rules on superlatives.
  ABOUT
  spec.homepage      = "https://github.com/psychoslave/englishest"
  spec.license       = "MIT"
  spec.required_ruby_version = ">= 2.5.0"

  spec.metadata["allowed_push_host"] = "https://mygemserver.com"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/psychoslave/englishest.git"
  spec.metadata["changelog_uri"] = "https://github.com/psychoslave/englishest/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "rspec", "~> 3.2"
end
