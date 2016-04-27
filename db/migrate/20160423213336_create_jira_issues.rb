class CreateJiraIssues < ActiveRecord::Migration
  def change
    create_table :jira_issues do |t|
      t.references :jira_repo, index: true
      t.string :key
      t.text :summary

      t.timestamps
    end
  end
end
