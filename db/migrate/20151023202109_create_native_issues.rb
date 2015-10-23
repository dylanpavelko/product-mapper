class CreateNativeIssues < ActiveRecord::Migration
  def change
    create_table :native_issues do |t|
      t.string :summary
      t.text :description
      t.boolean :enhancement
      t.references :issue_with, index: true
      t.references :resolved_with, index: true
      t.boolean :close_without_resolution

      t.timestamps
    end
  end
end
