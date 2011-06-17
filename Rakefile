require 'bundler'
require 'rake'
require 'spec/rake/spectask'

Bundler::GemHelper.install_tasks

task :default => [:test]

desc "Run all examples"
Spec::Rake::SpecTask.new('test') do |t|
  t.spec_files = FileList['spec/*_spec.rb']
end


