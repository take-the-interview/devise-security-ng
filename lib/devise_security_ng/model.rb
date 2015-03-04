require 'devise_lockable_extended/hooks/lockable_extended'

module Devise
  module Models
    module LockableExtended
      extend  ActiveSupport::Concern

      # Lock a user setting its locked_at to actual time.
      def lock_access!
        self.locked_at = Time.current
        self.save!
      end

      # Unlock a user by cleaning locked_at
      def unlock_access!
        self.locked_at = nil
        self.save!
      end

      # Verifies whether a user is locked or not.
      def access_locked?
        !!locked_at && !lock_expired?
      end

      # Overwrites active_for_authentication? from Devise::Models::Activatable
      def active_for_authentication?
        super && !access_locked?
      end

      # Overwrites inactive_message from Devise::Models::Authenticatable
      def inactive_message
        access_locked? ? locked_message : super
      end

      # Overwrites valid_for_authentication? from Devise::Models::Authenticatable
      # for verifying whether a user is allowed to sign in or not. If the user
      # is locked, it should never be allowed.
      def valid_for_authentication?
        # Unlock the user if the lock is expired, no matter
        # if the user can login or not (wrong password, etc)
        unlock_access! if lock_expired?

        if super && !access_locked?
          true
        else
          self.login_attempts ||= 0
          self.login_attempts += 1
          if attempts_exceeded? && !access_locked?
            lock_access!
          else
            self.save!
          end
          false
        end
      end

      # Overwrites update_tracked_fields! from Devise::Models::Trackable to be able to
      # verify if user successfully signed in
      def update_tracked_fields!(request)
        self.login_attempts = 0
        super
      end

      def unauthenticated_message
        # If set to paranoid mode, do not show the locked message because it
        # leaks the existence of an account.
        if Devise.paranoid
          super
        elsif access_locked? || attempts_exceeded?
          locked_message
        elsif last_attempt? && self.class.last_attempt_warning
          :last_attempt
        else
          super
        end
      end

      protected

        def attempts_exceeded?
          self.login_attempts >= self.class.maximum_login_attempts
        end

        def last_attempt?
          self.login_attempts == self.class.maximum_login_attempts - 1
        end

        def locked_message
          case self.login_attempts
          when 3..6
            :locked_3
          when 6..9
            :locked_6
          when 9..1.0/0
            :locked_9
          else
            :locked
          end
        end

        # Checking if lock is expired
        def lock_expired?
          if locked_at
            case self.login_attempts
            when 3..6
              (self.locked_at + 1.minutes).to_i < Time.current.to_i
            when 6..9
              (self.locked_at + 60.minutes).to_i < Time.current.to_i
            when 9..1.0/0
              false
            else
              true
            end
          else
            false
          end
        end

      module ClassMethods
        Devise::Models.config(self, :maximum_login_attempts, :last_attempt_warning)
      end
    end
  end
end
