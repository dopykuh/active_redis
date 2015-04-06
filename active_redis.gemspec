# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'active_redis/version'

Gem::Specification.new do |spec|
  spec.name          = "active_redis"
  spec.version       = ActiveRedis::VERSION
  spec.authors       = ["Tim Foerster"]
  spec.email         = ["timhormersdorf@googlemail.com"]
  spec.summary       = "Get redis relational"
  spec.license       = "MIT"

  spec.files         = [
    Dir['lib/**/*.rb'],
    'README.md'
  ].flatten
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.8"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 4.7.3"
  
  spec.add_dependency "redis"
end
