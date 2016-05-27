require "bundler/setup"
require "rake/testtask"

Rake::TestTask.new(:test) do |t|
  t.libs << "test"
  t.libs << "lib"
  t.test_files = FileList['test/**/*_test.rb']
end

task :console do
  Dir['./lib/*.rb', './lib/*/*.rb'].each { |file| require file }
  require 'pry'
  ARGV.clear
  Pry.start
end

task default: :test
