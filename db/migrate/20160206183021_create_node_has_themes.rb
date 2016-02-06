class CreateNodeHasThemes < ActiveRecord::Migration
  def change
    create_table :node_has_themes do |t|
      t.references :node, index: true
      t.references :theme, index: true

      t.timestamps
    end
  end
end
