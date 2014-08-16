# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'burlesque/version'

Gem::Specification.new do |spec|
  spec.name          = 'burlesque-client'
  spec.version       = Burlesque::VERSION
  spec.authors       = ['Gregory Eremin']
  spec.email         = ['g@erem.in']
  spec.summary       = %q{Burlesque API wrapper}
  spec.description   = %q{Ruby wrapper over Burlesque message queue API}
  spec.homepage      = 'http://github.com/KosyanMedia/burlesque'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '>= 1.6'
  spec.add_development_dependency 'rake'
end
