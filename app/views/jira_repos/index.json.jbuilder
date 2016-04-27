json.array!(@jira_repos) do |jira_repo|
  json.extract! jira_repo, :id, :name, :url
  json.url jira_repo_url(jira_repo, format: :json)
end
