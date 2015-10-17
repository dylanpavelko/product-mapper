class CreateUserHasFavoriteNodes < ActiveRecord::Migration
  def change
    create_table :user_has_favorite_nodes do |t|
      t.references :user, index: true
      t.references :node, index: true

      t.timestamps
    end
  end
end
