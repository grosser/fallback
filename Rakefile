require 'spec/rake/spectask'
Spec::Rake::SpecTask.new {|t| t.spec_opts = ['--color']}
task :default => :spec

begin
  require 'jeweler'
  project_name = 'fallback'
  Jeweler::Tasks.new do |gem|
    gem.name = project_name
    gem.summary = "Fallback when original is not present or somethings not right."
    gem.email = "grosser.michael@gmail.com"
    gem.homepage = "http://github.com/grosser/#{project_name}"
    gem.authors = ["Michael Grosser"]
  end

  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler, or one of its dependencies, is not available. Install it with: sudo gem install jeweler"
end