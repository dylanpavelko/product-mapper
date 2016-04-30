class CreateNativeIssueHasImpacts < ActiveRecord::Migration
  def change
    create_table :native_issue_has_impacts do |t|
      t.references :customer, index: true
      t.references :native_issue, index: true
      t.integer :impact

      t.timestamps
    end
  end
end
