# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "brew-go"
  spec.version       = "1.1.1"
  spec.authors       = ["Marco Hinz"]
  spec.email         = ["mh.codebro+github@gmail.com"]

  spec.summary       = "Manage Go tools via Homebrew."
  spec.description   = spec.summary
  spec.homepage      = "https://github.com/mhinz/brew-go"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  spec.bindir        = "bin"
  spec.executables   = ["brew-go"]

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
end
