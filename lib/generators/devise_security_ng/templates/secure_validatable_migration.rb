class DeviseAddSecurityNgSecureValidatable<%= table_name.camelize.singularize %> < ActiveRecord::Migration
  def self.up
    add_column :<%= table_name %>, :char_limitable, :boolean, default: false
  end
  
  def self.down
    remove_column :<%= table_name %>, :char_limitable
  end
end
