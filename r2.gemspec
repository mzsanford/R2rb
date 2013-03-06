# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "r2/version"

Gem::Specification.new do |s|
  s.name        = "r2"
  s.version     = R2::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Matt Sanford"]
  s.email       = ["matt@twitter.com"]
  s.homepage    = ""
  s.summary     = %q{CSS flipper for right-to-left processing}
  s.description = %q{CSS flipper for right-to-left processing. A Ruby port of https://github.com/ded/r2}

  s.rubyforge_project = "r2"

  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec', '~> 1.3.0'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
