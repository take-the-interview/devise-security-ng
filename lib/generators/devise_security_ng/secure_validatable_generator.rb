require 'rails/generators/active_record'

module DeviseSecurityNg
  module Generators
    class SecureValidatableGenerator < Rails::Generators::NamedBase
      include Rails::Generators::Migration

      def add_configs
        inject_into_file "config/initializers/devise.rb", "\n  # ==> Security NG secure_validatable\n  # Configure security ng secure_validatable for devise\n\n" +
        "  # enable email validation for :secure_validatable. (true, false, validation_options)\n" +
        "  # dependency: need an email validator like rails_email_validator\n" +
        "  # config.email_validation = true\n\n" +
        "  # Validate password for strongness\n" +
        "  # config.password_regex = /(?=.*\d)(?=.*[a-z])(?=.*[A-Z])/\n\n" +
        "  # How many times character can be repeated in a password (0 to disable)\n" +
        "  # config.char_repeatable_limit = 0\n" +
        "", :before => /end[ |\n|]+\Z/
      end
    end
  end
end
