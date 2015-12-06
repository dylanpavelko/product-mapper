class CreateQuestionHasResponses < ActiveRecord::Migration
  def change
    create_table :question_has_responses do |t|
      t.references :question, index: true
      t.references :response, index: true
      t.boolean :answers

      t.timestamps
    end
  end
end
