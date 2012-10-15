$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "exposure/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "exposure"
  s.version     = Exposure::VERSION
  s.authors     = ["James Kassemi (@Pay)"]
  s.email       = ["james@atpay.com"]
  s.homepage    = "https://github.com/easygive/exposure"
  s.summary     = "Provide AR subclassing without enabling STI"
  s.description = "Gives us the ability to use different interfaces into a single model"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.6"

  s.add_development_dependency "sqlite3"
end
