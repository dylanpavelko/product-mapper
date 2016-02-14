json.array!(@native_issue_has_responses) do |native_issue_has_response|
  json.extract! native_issue_has_response, :id, :native_issue_id, :response_id
  json.url native_issue_has_response_url(native_issue_has_response, format: :json)
end
