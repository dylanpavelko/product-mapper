json.array!(@jira_issues) do |jira_issue|
  json.extract! jira_issue, :id, :jira_repo_id, :key, :summary
  json.url jira_issue_url(jira_issue, format: :json)
end
