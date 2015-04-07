require 'rails/generators/active_record'

module DeviseSecurityNg
  module Generators
    class PasswordExpirableGenerator < Rails::Generators::NamedBase
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
        migration_template 'password_expirable_migration.rb', "db/migrate/devise_add_security_ng_password_expirable_#{name.downcase}.rb"
      end

      def add_configs
        inject_into_file "config/initializers/devise.rb", "\n  # ==> Security NG Password Expirable\n  # Configure security ng password_expirable for devise\n\n" +
        "  # # Force password change after N days\n" +
        "  # false to disable\n" +
        "  # 0 per user\n" +
        "  # <num> global setting\n" +
        "  # expire_password_after = 90\n" +
        "", :before => /end[ |\n|]+\Z/
      end
    end
  end
end