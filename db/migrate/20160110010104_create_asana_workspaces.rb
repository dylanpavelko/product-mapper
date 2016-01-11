class CreateAsanaWorkspaces < ActiveRecord::Migration
  def change
    create_table :asana_workspaces do |t|
      t.string :workspace
      t.references :node, index: true
      t.references :added_by, index: true

      t.timestamps
    end
  end
end
