require 'active_record'
class OldPassword < ActiveRecord::Base
  belongs_to :password_reusable, :polymorphic => true
end

module Devise
  module Models
    module PasswordReusable
      extend  ActiveSupport::Concern

      included do
        has_many :old_passwords, :as => :password_reusable, :dependent => :destroy
        before_update :archive_password
        validate :password_already_used, on: :update
      end

      def password_already_used
        if self.changed_attributes.key?(:encrypted_password)
          if self.old_passwords.where(encrypted_password: self.changed_attributes.encrypted_password)
            self.errors.add(:password, :used_in_past)
          end
        end
      end

      def archive_password
        if self.encrypted_password_changed? 
          if self.class.password_reusable_after > 0
            salt = self.password_salt_changed? ? self.password_salt_change.first : self.password_salt
            self.old_passwords.create!(
                encrypted_password: self.encrypted_password_change.first,
                password_salt: salt
              )
            self.old_passwords.order(:id).reverse_order.offset(self.class.password_reusable_after).destroy_all
          else
            self.old_passwords.destroy_all
          end
        end
      end

      module ClassMethods
        Devise::Models.config(self, :password_reusable_after)
      end
    end
  end
end
