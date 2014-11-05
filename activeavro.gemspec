# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'active_avro/version'

Gem::Specification.new do |spec|
  spec.name          = 'activeavro'
  spec.version       = ActiveAvro::VERSION
  spec.author        = 'Ches Martin'
  spec.email         = 'ches@whiskeyandgrits.net'
  spec.summary       = 'Rich objects for a better Avro experience in Ruby.'
  spec.description   = spec.summary
  spec.homepage      = 'https://github.com/ches/activeavro'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'avro', '~> 1.7.7'
  spec.add_dependency 'virtus', '~> 1.0.3'

  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'rake', '~> 10.1.0'
  spec.add_development_dependency 'rspec', '~> 3.1.0'
end

