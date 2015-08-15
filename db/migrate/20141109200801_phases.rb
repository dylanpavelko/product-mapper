class Phases < ActiveRecord::Migration
  def change
    create_table :phases do |t|
      t.references :phaseComponent
      t.boolean :requiredForRelease

      t.timestamps
    end
  end
end