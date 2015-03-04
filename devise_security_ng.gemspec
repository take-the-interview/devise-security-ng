$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "devise_security_ng/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "devise_security_ng"
  s.version     = DeviseSecurityNg::VERSION
  s.authors     = ["Alen Komic"]
  s.email       = ["akomic@taketheinterview.com"]
  s.homepage    = "http://www.aksiom.net"
  s.summary     = "Devise Security NG version with complex locking mechanism."
  s.description = "Devise Security NG with complex locking mechanism"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.licenses = ["MIT"]

  s.add_dependency "rails", "~> 4.0"

  s.add_development_dependency "sqlite3", "~> 1.3"
end
