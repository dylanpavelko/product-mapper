class CreateNodes < ActiveRecord::Migration
  def change
    create_table :nodes do |t|
      t.string :name
      t.belongs_to :parent

      t.references :nodeType, index: true

      t.timestamps
    end
  end
end
