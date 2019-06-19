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
  spec.executables   = ['carthage_audit']
  spec.add_development_dependency 'rspec', '~> 3.8'
  spec.test_files    = ['spec/audit_spec.rb']
  spec.require_paths = ["lib"]
end
