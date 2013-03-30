# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'str2hash/version'

Gem::Specification.new do |spec|
  
  spec.name          = "str2hash"
  spec.version       = Str2Hash::VERSION
  spec.authors       = ["karl l"]
  spec.email         = ["karl@ninjacontrol.com"]
  spec.date          = '2013-03-29'
  spec.summary       = "Convert string to hash"
  spec.description   = "Tiny parser for converting strings to hashes (without using eval)."
  spec.homepage      = "https://github.com/karlll/str2hash/"
  spec.license       = "MIT"
  
  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]
  
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_runtime_dependency "parslet"
 
  end
  