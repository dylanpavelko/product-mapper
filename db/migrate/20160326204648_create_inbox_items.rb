class CreateInboxItems < ActiveRecord::Migration
  def change
    create_table :inbox_items do |t|
      t.references :user, index: true
      t.references :activity, index: true
      t.boolean :read

      t.timestamps
    end
  end
end
