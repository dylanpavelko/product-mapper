class CreateAgendaItems < ActiveRecord::Migration
  def change
    create_table :agenda_items do |t|
      t.string :name
      t.references :meeting, index: true
      t.integer :order

      t.timestamps
    end
  end
end
