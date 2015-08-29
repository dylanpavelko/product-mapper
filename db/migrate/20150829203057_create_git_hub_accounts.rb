class CreateGitHubAccounts < ActiveRecord::Migration
  def change
    create_table :git_hub_accounts do |t|
      t.string :oauth
      t.references :user, index: true

      t.timestamps
    end
  end
end
