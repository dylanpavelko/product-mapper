class CreateJiraRepos < ActiveRecord::Migration
  def change
    create_table :jira_repos do |t|
      t.string :name
      t.string :url

      t.timestamps
    end
  end
end
