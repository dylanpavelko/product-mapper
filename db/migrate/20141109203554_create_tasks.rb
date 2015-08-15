class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :name
      t.references :phase
      t.references :node
      t.boolean :requiredForRelease

      t.timestamps

      rename_column(:tasks, :forNode, :node)
    end

  end
end
