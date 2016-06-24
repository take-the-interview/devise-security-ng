require 'active_record'
require 'active_support/core_ext/integer'
require 'active_support/ordered_hash'
require 'active_support/concern'
require 'devise'

module Devise
  mattr_accessor :maximum_login_attempts
  @@maximum_login_attempts = 3

  # Should we alert the user of imminent account locking?
  mattr_accessor :last_attempt_warning
  @@last_attempt_warning = true

  # Should we notify the owner of the account of imminent permanent account locking?
  mattr_accessor :account_locked_warning
  @@account_locked_warning = true

  # Activation flag
  mattr_accessor :user_lockable
  @@user_lockable = true

  # Passwords to keep in archive, 0 to disable
  mattr_accessor :password_reusable_after
  @@password_reusable_after = 5

  # Force password change after N days
  mattr_accessor :expire_password_after
  @@expire_password_after = 90

  # Validate password for strongness
  mattr_accessor :password_regex
  @@password_regex = /(?=.*\d)(?=.*[a-z])(?=.*[A-Z])/

  # Validate password for repeated characters
  mattr_accessor :char_repeatable_limit
  @@char_repeatable_limit = 0

  # enable email validation for :secure_validatable. (true, false, validation_options)
  # dependency: need an email validator like rails_email_validator
  mattr_accessor :email_validation
  @@email_validation = true
end

module DeviseSecurityNg
  module Controllers
    autoload :Helpers, 'devise_security_ng/controllers/helpers'
  end
end

Devise.add_module :password_expirable, :controller => :password_expirable, :model => 'devise_security_ng/models/password_expirable', :route => :password_expired
Devise.add_module :user_lockable, :controller => :user_lockable, :model => 'devise_security_ng/models/user_lockable', :route => :unlock
Devise.add_module :password_reusable, :model => 'devise_security_ng/models/password_reusable'
Devise.add_module :secure_validatable, :model => 'devise_security_ng/models/secure_validatable'

# requires
require 'devise_security_ng/routes'
require 'devise_security_ng/rails'
require 'devise_security_ng/models/database_authenticatable_patch'
