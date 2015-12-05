class AddAskedByUserToQuestions < ActiveRecord::Migration
  def change
    add_reference :questions, :asked_by_user, index: true
  end
end
