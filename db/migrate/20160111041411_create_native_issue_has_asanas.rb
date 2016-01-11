class CreateNativeIssueHasAsanas < ActiveRecord::Migration
  def change
    create_table :native_issue_has_asanas do |t|
      t.references :asana_task, index: true
      t.references :native_issue, index: true

      t.timestamps
    end
  end
end
