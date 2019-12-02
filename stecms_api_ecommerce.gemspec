$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "stecms_api_ecommerce/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "stecms_api_ecommerce"
  s.version     = StecmsApiEcommerce::VERSION
  s.authors       = ["Hendry Firman", "LipsiaGroup"]
  s.email         = ["hendry@kopihub.com", "stefano.ramponi@lipsiagroup.com", "stefano.ramponi@lipsiagroup.com", "valerio.liparoti@lipsiagroup.com"]

  s.summary       = "Gem for get products"
  s.description   = "This gem for get data products ecommerce from store on admin"
  s.homepage      = "https://www.lipsiagroup.com/it"
  s.license       = "MIT"


  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2.8"
  s.add_dependency 'dotenv-rails'
  s.add_dependency 'rest-client'
  s.add_dependency 'kaminari'
  s.add_development_dependency "sqlite3"
end
