# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'screening/version'

Gem::Specification.new do |spec|
  spec.name          = "screening"
  spec.version       = Screening::VERSION
  spec.authors       = ["phyten"]
  spec.email         = ["phyten.obr@gmail.com"]
  spec.description   = "The purpose of this library is that screening."
  spec.summary       = "The purpose of this library is that screening."
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'activesupport', ['>= 3.0.0']
  spec.add_dependency 'actionpack', ['>= 3.0.0']
  spec.add_dependency 'moji'

  spec.add_development_dependency 'bundler', ['>= 1.0.0']
  spec.add_development_dependency 'rake', ['>= 0']
  spec.add_development_dependency 'rspec', ['>= 0']
  spec.add_development_dependency 'rdoc', ['>= 0']
  spec.add_development_dependency 'pry'

  
end
