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
        before_update :archive_password, on: :update
        validate :password_unused?, on: :update
      end

      def password_unused?
        self.errors.add(:password, :used_in_past) if self.encrypted_password_changed? && self.password_already_used?
      end

      def password_already_used?
        return true if self.password_reusable_archive_size > 0 && ! self.password.nil? && self.old_passwords.where(hash_password: Digest::SHA512.hexdigest(self.password)).present?
        return false
      end

      def password_reusable_archive_size
        return 0 if self.class.password_reusable_after==false
        return self.password_reusable if self.class.password_reusable_after == 0 && self.password_reusable > 0 
        return self.class.password_reusable_after
      end

      def archive_password
        if !!self.password_reusable_archive_size
          if self.encrypted_password_changed? && ! self.password.nil?
            if self.password_reusable_acrhive_size > 0
              salt = self.password_salt_changed? ? self.password_salt_change.first : self.password_salt
              if ! password_already_used?
                self.old_passwords.create!(
                    encrypted_password: self.encrypted_password_change.first,
                    hash_password: Digest::SHA512.hexdigest(self.password),
                    password_salt: salt
                  )
                self.old_passwords.order(:id).reverse_order.offset(self.password_reusable_acrhive_size).destroy_all
              end
            end
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
