class DeviseAddSecurityNgPasswordReusable<%= table_name.camelize.singularize %> < ActiveRecord::Migration
  def self.up
    create_table :old_passwords do |t|
      t.integer :user_id
      t.string :encrypted_password
      t.string :password_salt

      t.timestamps
    end
  end
  
  def self.down
    drop_table :old_passwords
  end
end