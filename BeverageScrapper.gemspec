# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'BeverageScrapper/version'

Gem::Specification.new do |spec|
  spec.name          = "BeverageScrapper"
  spec.version       = BeverageScrapper::VERSION
  spec.authors       = ["Joshua Weinstein"]
  spec.email         = ["jweinst1@berkeley.edu"]

  spec.summary       = %q{A Gem API for data mining information on beverages and drinks from text.}
  spec.description   = %q{BeverageScrapper is a Gem that allows you to mine data about soft drinks and beverages from text. It has many features
such as giving you information on how often a drink is mentioned, if the opinion of the drink is positive or negative, and much more.\nBeverageScrapper is perfect for getting information about consumer opinions or trends about drink purchasing.
Check out the home page for more information or the documentation.}
  spec.homepage      = "https://github.com/jweinst1/BeverageScrapper"
  spec.license       = "MIT"


  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
end
