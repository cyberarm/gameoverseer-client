# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'gameoverseer/client/version'

Gem::Specification.new do |spec|
  spec.name          = "gameoverseer-client"
  spec.version       = GameOverseer::Client::VERSION
  spec.authors       = ["Cyberarm"]
  spec.email         = ["matthewlikesrobots@gmail.com"]
  spec.summary       = %q{Client library for GameOverseer.}
  spec.description   = %q{Library for easily communicating with a GameOverseer server.}
  spec.homepage      = "https://github.com/cyberarm/gameoverseer-client"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "renet", ">= 0.2.0"
  spec.add_dependency "multi_json"

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end
