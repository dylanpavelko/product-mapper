class AddLeadToUserHasRoleForNodes < ActiveRecord::Migration
  def change
    add_column :user_has_role_for_nodes, :lead, :boolean
  end
end
