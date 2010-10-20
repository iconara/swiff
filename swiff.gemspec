# -*- encoding: utf-8 -*-
require File.expand_path('../lib/swiff/version', __FILE__)

Gem::Specification.new do |s|
  s.name        = 'swiff'
  s.version     = Swiff::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['Andrei Bocan', 'Theo Hultberg', 'Dennis Zhuang']
  s.email       = []
  s.homepage    = 'http://github.org/2performant/swiff'
  s.summary     = 'SWF file format utility'
  s.description = 'Swiff can compress, decompress and read SWF file headers.'

  s.required_rubygems_version = '>= 1.3.6'
  s.rubyforge_project         = 'swiff'

  s.add_development_dependency 'bundler', '~> 1.0.0'
  s.add_development_dependency 'rake', '~> 0.8.7'
  s.add_development_dependency 'thoughtbot-shoulda'

  s.files        = `git ls-files`.split("\n")
  s.executables  = `git ls-files`.split("\n").map{|f| f =~ /^bin\/(.*)/ ? $1 : nil}.compact
  s.require_path = 'lib'
end
