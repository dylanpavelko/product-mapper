class CreatePhases < ActiveRecord::Migration
  def change
  	drop_table :phases
    create_table :phases do |t|
      t.references :phaseType
      t.references :node
      t.string :completionStatus

      t.timestamps
    end
  end
end
