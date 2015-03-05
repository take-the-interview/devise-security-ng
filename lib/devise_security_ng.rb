unless defined?(Devise)
  require 'devise'
end
require 'devise_security_ng'
require 'devise_security_ng/rails'

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

Devise.add_module :security_ng, :model => 'devise_security_ng/model'
