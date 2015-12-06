class QuestionHasResponse < ActiveRecord::Base
  belongs_to :question, class_name: "Question", foreign_key: "question_id"
  belongs_to :response, class_name: "Response", foreign_key: "response_id"
end
