class CreateActionItems < ActiveRecord::Migration
  def change
    create_table :action_items do |t|
      t.string :name
      t.text :description
      t.boolean :complete
      t.datetime :completed
      t.date :due_override
      t.references :due_by_meeting, index: true
      t.references :action_from_agenda_item, index: true

      t.timestamps
    end
  end
end
