$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "paramedic/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name          = "paramedic"
  s.version       = Paramedic::VERSION
  s.authors       = ["Nisanth Chunduru"]
  s.email         = ["nisanth074@gmail.com"]
  s.homepage      = "https://github.com/nisanth074/paramedic"
  s.summary       = "A Stripe API inspired validation library for Rails"
  s.description   = "A Stripe API inspired validation library for Rails"

  s.files = Dir["{lib}/**/*", "README.md"]

  s.add_development_dependency "rspec", '~> 3.9'
  s.add_development_dependency "pry"
  s.add_development_dependency "rake"
end