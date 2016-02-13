class AddAddedByToNativeIssues < ActiveRecord::Migration
  def change
    add_reference :native_issues, :added_by, index: true
  end
end
