require 'rails/generators/active_record'

module DeviseSecurityNg
  module Generators
    class UserLockableGenerator < Rails::Generators::NamedBase
      include Rails::Generators::Migration

      def self.source_root
        @_devise_source_root ||= File.expand_path("../templates", __FILE__)
      end

      def self.orm_has_migration?
        Rails::Generators.options[:rails][:orm] == :active_record
      end

      def self.next_migration_number(dirname)
        if ActiveRecord::Base.timestamped_migrations
          Time.now.utc.strftime("%Y%m%d%H%M%S")
        else
          "%.3d" % (current_migration_number(dirname) + 1)
        end
      end

      def create_migration_file
        migration_template 'user_lockable_migration.rb', "db/migrate/devise_add_security_ng_user_lockable_#{name.downcase}.rb"
      end

      def add_configs
        inject_into_file "config/initializers/devise.rb", "\n  # ==> Security NG user_lockable\n  # Configure security ng user_lockable for devise\n\n" +
        "  # Maximum login attempts before first lock\n" +
        "  # config.maximum_login_attempts = 3\n\n" +
        "  # Should we alert the user of imminent account locking?\n" +
        "  # config.last_attempt_warning = true\n" +
        "  # Should we notify the owner of the account of imminent permanent account locking?\n" +
        "  # config.account_locked_warning = true\n" +
        "", :before => /end[ |\n|]+\Z/
      end
    end
  end
end
