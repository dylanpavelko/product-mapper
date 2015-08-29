json.array!(@git_hub_repos) do |git_hub_repo|
  json.extract! git_hub_repo, :id, :repo, :node_id, :user_id
  json.url git_hub_repo_url(git_hub_repo, format: :json)
end
