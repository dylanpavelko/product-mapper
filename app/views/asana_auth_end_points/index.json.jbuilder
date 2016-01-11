json.array!(@asana_auth_end_points) do |asana_auth_end_point|
  json.extract! asana_auth_end_point, :id, :user_id, :auth_code, :bearer_token_id, :token_date, :refresh_token
  json.url asana_auth_end_point_url(asana_auth_end_point, format: :json)
end
