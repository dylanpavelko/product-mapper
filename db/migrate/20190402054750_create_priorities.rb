class CreatePriorities < ActiveRecord::Migration
  def change
    create_table :priorities do |t|
      t.decimal :score
      t.references :node, index: true

      t.timestamps
    end
  end
end
