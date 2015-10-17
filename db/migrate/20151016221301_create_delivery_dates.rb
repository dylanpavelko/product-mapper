class CreateDeliveryDates < ActiveRecord::Migration
  def change
    create_table :delivery_dates do |t|
      t.references :node, index: true
      t.integer :target_type
      t.references :envrionment, index: true
      t.references :milestone, index: true
      t.date :date

      t.timestamps
    end
  end
end
