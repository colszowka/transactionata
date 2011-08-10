# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "transactionata/version"

Gem::Specification.new do |s|
  s.name        = "transactionata"
  s.version     = Transactionata::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Christoph Olszowka"]
  s.email       = ["christoph at olszowka de"]
  s.homepage    = ""
  s.summary     = %q{Transactionata: Transactional dynamic test data for Rails Tests. Set up your models and factories in a block that will be executed once and then rolled back by hooking into ActiveRecord's built-in fixture transactions}
  s.description = %q{Transactionata: Transactional dynamic test data for Rails Tests. Set up your models and factories in a block that will be executed once and then rolled back by hooking into ActiveRecord's built-in fixture transactions}

  s.rubyforge_project = "transactionata"
  
  s.add_development_dependency 'shoulda'
  s.add_development_dependency 'rails'
  s.add_development_dependency 'rake'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
