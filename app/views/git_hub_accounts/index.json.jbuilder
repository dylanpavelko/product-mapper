json.array!(@git_hub_accounts) do |git_hub_account|
  json.extract! git_hub_account, :id, :oauth, :user_id
  json.url git_hub_account_url(git_hub_account, format: :json)
end
