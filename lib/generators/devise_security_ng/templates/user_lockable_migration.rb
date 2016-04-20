class DeviseAddSecurityNgUserLockable<%= table_name.camelize.singularize %> < ActiveRecord::Migration
  def self.up
    add_column :<%= table_name %>, :locked_at, :datetime
    add_column :<%= table_name %>, :login_attempts, :integer
    add_column :<%= table_name %>, :lockable, :boolean, default: false
    add_column :<%= table_name %>, :unlock_token, :string
  end
  
  def self.down
    remove_column :<%= table_name %>, :locked_at
    remove_column :<%= table_name %>, :login_attempts
    remove_column :<%= table_name %>, :lockable
    remove_column :<%= table_name %>, :unlock_token
  end
end
