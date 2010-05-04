# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{fallback}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Michael Grosser"]
  s.date = %q{2010-05-04}
  s.email = %q{grosser.michael@gmail.com}
  s.files = [
    "Rakefile",
     "Readme.md",
     "VERSION",
     "lib/fallback.rb",
     "spec/database.rb",
     "spec/fallback_spec.rb",
     "spec/spec_helper.rb"
  ]
  s.homepage = %q{http://github.com/grosser/fallback}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.6}
  s.summary = %q{Fallback when original is not present or somethings not right.}
  s.test_files = [
    "spec/fallback_spec.rb",
     "spec/database.rb",
     "spec/spec_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end

