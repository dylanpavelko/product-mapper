json.array!(@native_issue_has_jiras) do |native_issue_has_jira|
  json.extract! native_issue_has_jira, :id, :jira_id, :native_issue_id
  json.url native_issue_has_jira_url(native_issue_has_jira, format: :json)
end
