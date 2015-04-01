class DeviseAddSecurityNgPasswordReusable<%= table_name.camelize.singularize %> < ActiveRecord::Migration
  def self.up
    create_table :old_passwords do |t|
      t.string :encrypted_password
      t.string :hash_password
      t.string :password_salt
      t.integer :password_reusable_id, null: false
      t.integer :password_reusable_type, null: false

      t.timestamps
    end
  end
  
  def self.down
    drop_table :old_passwords
  end
end