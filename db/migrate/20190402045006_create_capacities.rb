class CreateCapacities < ActiveRecord::Migration
  def change
    create_table :capacities do |t|
      t.decimal :amount
      t.references :team, index: true
      t.references :milestone, index: true

      t.timestamps
    end
  end
end
