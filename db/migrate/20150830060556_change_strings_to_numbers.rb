class ChangeStringsToNumbers < ActiveRecord::Migration
  def change
    drop_table :git_hub_issues
    create_table :git_hub_issues do |t|
      t.number :gitHubID
      t.number :number
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
