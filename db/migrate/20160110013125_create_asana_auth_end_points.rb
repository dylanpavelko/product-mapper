class CreateAsanaAuthEndPoints < ActiveRecord::Migration
  def change
    create_table :asana_auth_end_points do |t|
      t.references :user, index: true
      t.string :auth_code
      t.string :bearer_token
      t.datetime :token_date
      t.string :refresh_token

      t.timestamps
    end
  end
end
