class CreateProfileImages < ActiveRecord::Migration
  def change
    create_table :profile_images do |t|
      t.references :user, index: true
      t.attachment :image

      t.timestamps
    end
  end
end
