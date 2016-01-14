class AddUrlToAsanaTask < ActiveRecord::Migration
  def change
    add_column :asana_tasks, :url, :string
  end
end
