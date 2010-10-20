require 'bundler'
require 'rake'
require 'rake/testtask'

Bundler::GemHelper.install_tasks


task :default => :test


Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end
