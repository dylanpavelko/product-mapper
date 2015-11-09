class CreateUserHasRoleForNodes < ActiveRecord::Migration
  def change
    create_table :user_has_role_for_nodes do |t|
      t.references :user, index: true
      t.references :role, index: true
      t.references :node, index: true

      t.timestamps
    end
  end
end
