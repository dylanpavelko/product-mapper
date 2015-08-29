class CreateGitHubRepos < ActiveRecord::Migration
  def change
    create_table :git_hub_repos do |t|
      t.string :repo
      t.references :node, index: true
      t.references :user, index: true

      t.timestamps
    end
  end
end
