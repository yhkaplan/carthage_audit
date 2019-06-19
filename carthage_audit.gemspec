# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "carthage_audit"
  spec.version       = '1.0'
  spec.authors       = ["Joshua Kaplan"]
  spec.email         = ["yhkaplan@gmail.com"]
  spec.summary       = %q{Short summary of your project}
  spec.description   = %q{Longer description of your project.}
  spec.homepage      = "http://domainforproject.com/"
  spec.license       = "MIT"

  spec.files         = [
    'Gemfile',
    'lib/carthage_audit.rb',
  ]
  spec.executables   = ['bin/carthage_audit']
  spec.test_files    = ['tests/test_NAME.rb']
  spec.require_paths = ["lib"]
end
