require 'rake'
require 'rake/testtask'

desc 'Default: run hhd_shopping_cart unit tests.'
task :default => :test

desc 'Test the hhd_shopping_cart plugin.'
Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
end
