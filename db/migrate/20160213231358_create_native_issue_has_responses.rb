class CreateNativeIssueHasResponses < ActiveRecord::Migration
  def change
    create_table :native_issue_has_responses do |t|
      t.references :native_issue, index: true
      t.references :response, index: true

      t.timestamps
    end
  end
end
