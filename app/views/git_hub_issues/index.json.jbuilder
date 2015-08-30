json.array!(@git_hub_issues) do |git_hub_issue|
  json.extract! git_hub_issue, :id, :gitHubID, :number, :title, :created, :updated, :closed, :body, :node_id, :repo_id
  json.url git_hub_issue_url(git_hub_issue, format: :json)
end
