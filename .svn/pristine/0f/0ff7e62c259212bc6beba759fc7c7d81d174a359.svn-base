json.array!(@questions) do |question|
  json.extract! question, :id, :question, :node, :phaseType, :resolved
  json.url question_url(question, format: :json)
end
