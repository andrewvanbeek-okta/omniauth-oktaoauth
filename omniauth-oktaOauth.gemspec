$:.push File.expand_path("../lib", __FILE__)

require "omniauth-oktaoauth/version"

Gem::Specification.new do |s|
  s.name          = "omniauth-oktaoauth"
  s.version       = OmniAuth::Oktaoauth::VERSION
  s.authors       = ["Dan Andrews", "Andrew Van Beek"]
  s.email         = ["andrew.vanbeek@okta.com"]
  s.email         = ["andrew.vanbeek@okta.com"]
  s.homepage      = ""
  s.summary       = %q{OmniAuth OAuth2 strategy for Okta}
  s.description   = %q{OmniAuth OAuth2 strategy for Okta}
  s.license       = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "omniauth", "~> 2.0"
  s.add_dependency "omniauth-oauth2", ">= 1.4.0", "< 2.0"

  s.add_development_dependency "bundler", "~> 1.5"
  s.add_development_dependency "rake"
  s.add_development_dependency "rspec", "~> 2.7"
  s.add_development_dependency "rack-test"
end
