class CreateAsanaTasks < ActiveRecord::Migration
  def change
    create_table :asana_tasks do |t|
      t.string :name
      t.string :asana_id
      t.references :asana_workspace, index: true

      t.timestamps
    end
  end
end
