# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'gameoverseer/client/version'

Gem::Specification.new do |spec|
  spec.name          = "gameoverseer-client"
  spec.version       = Gameoverseer::Client::VERSION
  spec.authors       = ["Cyberarm"]
  spec.email         = ["matthewlikesrobots@gmail.com"]
  spec.summary       = %q{Client for GameOverseer.}
  spec.description   = %q{Interface for GameOverseer, easily.}
  spec.homepage      = "https://github.com/cyberarm/gameoverseer-client"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "renet"
  spec.add_dependency "multi_json"

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end
