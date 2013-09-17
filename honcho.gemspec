$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "honcho/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "honcho"
  s.version     = Honcho::VERSION
  s.authors     = ["Hitendra & Sachin87"]
  s.email       = ["hitendrasingh1985@gmail.com"]
  s.homepage    = "https://github.com/hitendrasingh/honcho"
  s.summary     = "TODO: Summary of Honcho."
  s.description = "Simplest, Highly Customizable Administration Framework for Ruby on Rails with Zurb Foundation."

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.0.0"
  s.add_dependency "zurb-foundation"
  s.add_dependency "haml-rails"
  s.add_dependency "simple_form"
  s.add_dependency "devise"
  s.add_dependency "squeel"

  s.add_development_dependency "sqlite3"
end
