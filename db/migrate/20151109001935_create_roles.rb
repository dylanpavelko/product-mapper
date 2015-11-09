class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.string :name
      t.boolean :view_product
      t.boolean :edit_nodes
      t.boolean :prioritize
      t.boolean :manage_issues
      t.boolean :manage_phases

      t.timestamps
    end
  end
end
