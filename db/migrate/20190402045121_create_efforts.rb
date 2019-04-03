class CreateEfforts < ActiveRecord::Migration
  def change
    create_table :efforts do |t|
      t.decimal :amount
      t.references :team, index: true
      t.references :node, index: true

      t.timestamps
    end
  end
end
