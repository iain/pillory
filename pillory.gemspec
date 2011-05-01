# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "pillory/version"

Gem::Specification.new do |s|
  s.name        = "pillory"
  s.version     = Pillory::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Iain Hecker"]
  s.email       = ["iain@iain.nl"]
  s.homepage    = "http://iain.nl"
  s.summary     = %q{Runs all kinds of tools to torture your code, and tells any information to the authorities}
  s.description = %q{There are a great number of small tools to test the quality of your code. This gems runs them all and submits them to a server which can parse this information and show it in a pleasing way. Support for Cucumber, RSpec, Flog, Flay, Reek, Roodi and RBP are included, as well as some custom stuff. The goal for this gem is not to parse all this information, but to collect as much as possible.}

  s.rubyforge_project = "pillory"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency 'flay',                  '~> 1.4.2'
  s.add_dependency 'flog',                  '~> 2.5.1'
  s.add_dependency 'reek',                  '~> 1.2.8'
  s.add_dependency 'roodi',                 '~> 2.1.0'
  s.add_dependency 'rails_best_practices',  '~> 0.8.2'
  s.add_dependency 'ansi',                  '~> 1.2.4'
end
