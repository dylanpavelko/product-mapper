json.array!(@question_has_responses) do |question_has_response|
  json.extract! question_has_response, :id, :question_id, :response_id, :answers
  json.url question_has_response_url(question_has_response, format: :json)
end
