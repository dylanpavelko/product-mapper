class AddPriorityToNativeIssueHasImpact < ActiveRecord::Migration
  def change
    add_column :native_issue_has_impacts, :priority, :string
  end
end
