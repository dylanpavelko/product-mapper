class AddManagePeopleToRoles < ActiveRecord::Migration
  def change
    add_column :roles, :manage_people, :boolean
  end
end
