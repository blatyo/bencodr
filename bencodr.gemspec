# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "bencodr/version"

Gem::Specification.new do |s|
  s.name        = "bencodr"
  s.version     = BEncodr::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Allen Madsen"]
  s.email       = ["blatyo@gmail.com"]
  s.homepage    = "http://github.com/blatyo/bencodr"
  s.summary     = "This gem provides a way to encode and decode bencode used by the Bit Torrent protocol."
  s.description = "This gem provides a way to encode and decode bencode used by the Bit Torrent protocol. Normal ruby objects can be marshalled as bencode and demarshalled back to ruby."

  s.required_rubygems_version = ">= 1.3.6"
  s.add_development_dependency "rake"
  s.add_development_dependency "rspec",   "~> 2.8.0"
  s.add_development_dependency "bundler", ">= 1.0.0"
  s.add_development_dependency "fuubar",  ">= 1.0.0"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
