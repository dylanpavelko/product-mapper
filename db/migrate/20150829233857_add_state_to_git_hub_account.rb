class AddStateToGitHubAccount < ActiveRecord::Migration
  def change
  	add_column :git_hub_accounts, :state, :string
  end
end
