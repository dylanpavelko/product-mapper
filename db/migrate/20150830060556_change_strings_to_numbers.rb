class ChangeStringsToNumbers < ActiveRecord::Migration
  def change
  	change_column :git_hub_issues, :gitHubID, :integer
  	change_column :git_hub_issues, :number, :integer
  end
end
