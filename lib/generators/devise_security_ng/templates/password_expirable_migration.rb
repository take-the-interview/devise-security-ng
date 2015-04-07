class DeviseAddSecurityNgPasswordExpirable<%= table_name.camelize.singularize %> < ActiveRecord::Migration
  def self.up
    add_column :<%= table_name %>, :password_changed_at, :datetime
    add_column :<%= table_name %>, :password_expirable, :integer, default: 0
  end
  
  def self.down
    remove_column :<%= table_name %>, :password_changed_at
    remove_column :<%= table_name %>, :password_expirable
  end
end
