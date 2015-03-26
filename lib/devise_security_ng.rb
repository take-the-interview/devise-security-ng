require 'active_record'
require 'active_support/concern'
require 'devise'

module Devise
  mattr_accessor :maximum_login_attempts
  @@maximum_login_attempts = 3

  # Should we alert the user of imminent account locking?
  mattr_accessor :last_attempt_warning
  @@last_attempt_warning = true

  # Activation flag
  mattr_accessor :user_lockable
  @@user_lockable = true
end

Devise.add_module :user_lockable, :model => 'devise_security_ng/models/user_lockable'
Devise.add_module :password_reusable, :model => 'devise_security_ng/models/password_reusable'

# requires
require 'devise_security_ng/routes'
require 'devise_security_ng/rails'
require 'devise_security_ng/models/old_password'
