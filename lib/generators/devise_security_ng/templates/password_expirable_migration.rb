class DeviseAddSecurityNgPasswordExpirable<%= table_name.camelize.singularize %> < ActiveRecord::Migration
  def self.up
    add_column :<%= table_name %>, :password_changed_at, :datetime
  end
  
  def self.down
    remove_column :<%= table_name %>, :password_changed_at
  end
end
