class CreateNativeIssueHasJiras < ActiveRecord::Migration
  def change
    create_table :native_issue_has_jiras do |t|
      t.references :jira, index: true
      t.references :native_issue, index: true

      t.timestamps
    end
  end
end
