class CreateMilestones < ActiveRecord::Migration
  def change
    create_table :milestones do |t|
      t.string :name
      t.date :date
      t.boolean :major_release

      t.timestamps
    end
  end
end
