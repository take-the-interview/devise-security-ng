require 'active_record'
require 'active_support/concern'
require 'devise'
require 'devise_security_ng'

module Devise
  mattr_accessor :maximum_login_attempts
  @@maximum_login_attempts = 3

  # Should we alert the user of imminent account locking?
  mattr_accessor :last_attempt_warning
  @@last_attempt_warning = true

  # Activation flag
  mattr_accessor :user_lockable
  @@user_lockable = true

  # Passwords to keep in archive, 0 to disable
  mattr_accessor :password_reusable_after
  @@password_reusable_after = 5

  # Force password change after
  mattr_accessor :expire_password_after
  @@expire_password_after = 90.days
end

module DeviseSecurityNg
  module Controllers
    autoload :Helpers, 'devise_security_ng/controllers/helpers'
  end
end

Devise.add_module :user_lockable, :model => 'devise_security_ng/models/user_lockable'
Devise.add_module :password_reusable, :model => 'devise_security_ng/models/password_reusable'
Devise.add_module :password_expirable, :model => 'devise_security_ng/models/password_expirable'

# requires
require 'devise_security_ng/routes'
require 'devise_security_ng/rails'
