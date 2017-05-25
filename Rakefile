require 'bundler/gem_tasks'
task default: :spec

task :environment do
  require_relative 'lib/stuff'
end

desc 'Run console'
task console: :environment do
  require 'irb'
  ARGV.clear
  ARGV.concat [ "--readline", "--prompt-mode", "simple" ]
  IRB.start
end
task c: :console
