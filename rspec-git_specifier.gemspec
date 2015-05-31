# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rspec/git_specifier/version'

Gem::Specification.new do |spec|
  spec.name          = "rspec-git_specifier"
  spec.version       = RSpec::GitSpecifier::VERSION
  spec.authors       = ["meganemura"]
  spec.email         = ["meganemura@users.noreply.github.com"]

  spec.summary       = "Define RSpec helper methods to test against git repository (commits, branches, etc)."
  spec.description   = spec.summary
  spec.homepage      = "https://github.com/meganemura/rspec-git_specifier"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "rugged"

  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "guard-rspec"
end
