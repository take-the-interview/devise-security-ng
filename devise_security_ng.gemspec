$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "devise_security_ng/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "devise_security_ng"
  s.version     = DeviseSecurityNg::VERSION
  s.authors     = ["Alen Komic"]
  s.email       = ["akomic@taketheinterview.com"]
  s.homepage    = "https://github.com/take-the-interview/devise_security_ng"
  s.summary     = "Devise Security NG version with complex locking mechanism."
  s.description = "Devise Security NG with complex locking mechanism"

  s.files = Dir["{app,config,db,lib}/**/*", "LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]

  s.licenses = ["MIT"]

  s.add_dependency "rails", ">= 3.0"

  s.add_development_dependency "sqlite3", "~> 1.3"
end
