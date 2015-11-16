class CreateNodeHistories < ActiveRecord::Migration
  def change
    create_table :node_histories do |t|
      t.references :node, index: true
      t.references :user, index: true
      t.text :log
      t.integer :log_type
      t.references :other_node, index: true
      t.references :other_reference, index: true

      t.timestamps
    end
  end
end
