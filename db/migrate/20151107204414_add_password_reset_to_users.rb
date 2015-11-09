class AddPasswordResetToUsers < ActiveRecord::Migration
  def change
    add_column :users, :password_reset, :users
  end
end
