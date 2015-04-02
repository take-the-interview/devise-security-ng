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
    add_column :<%= table_name %>, :password_reusable, :integer, default: 0
  end
  
  def self.down
    drop_table :old_passwords
    remove_column :<%= table_name %>, :password_reusable
  end
end
