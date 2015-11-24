class AddAdministrativeToRoles < ActiveRecord::Migration
  def change
    add_column :roles, :administrative, :boolean
  end
end
