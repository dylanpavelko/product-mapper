class AddSubscribesToRoles < ActiveRecord::Migration
  def change
    add_column :roles, :subscribes, :boolean
  end
end
