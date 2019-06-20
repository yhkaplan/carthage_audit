# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "carthage_audit"
  spec.version       = '0.1.2'
  spec.authors       = ["Joshua Kaplan"]
  spec.email         = ["yhkaplan@gmail.com"]
  spec.summary       = %q{A tool to check if newer versions of Carthage dependencies contain security updates}
  spec.description   = %q{This tool is just a simple checker to see if newer versions of Carthage dependencies use keywords that relate to security}
  spec.homepage      = "http://github.com/yhkaplan/carthage_audit"
  spec.license       = "MIT"
  spec.files         = [
    'Gemfile',
    'lib/carthage_audit.rb',
  ]
  spec.executables   = ['carthage_audit']
  spec.add_development_dependency 'rspec', '~> 3.8'
  spec.add_runtime_dependency 'oga', '~> 2.15'
  spec.test_files    = ['spec/audit_spec.rb']
  spec.require_paths = ["lib"]
end
