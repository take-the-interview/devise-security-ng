module Devise
  module Models
    module PasswordReusable
      extend  ActiveSupport::Concern

      included do
        has_many :old_passwords, :dependent => :destroy
      end

      module ClassMethods
        Devise::Models.config(self, :password_reusable_after)
      end
    end
  end
end
