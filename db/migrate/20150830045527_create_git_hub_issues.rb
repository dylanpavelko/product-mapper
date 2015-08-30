class CreateGitHubIssues < ActiveRecord::Migration
  def change
    create_table :git_hub_issues do |t|
      t.string :gitHubID
      t.string :number
      t.string :title
      t.date :created
      t.date :updated
      t.date :closed
      t.string :body
      t.references :node, index: true
      t.references :repo, index: true

      t.timestamps
    end
  end
end
