json.array!(@dependables) do |dependable|
  json.extract! dependable, :id
  json.url dependable_url(dependable, format: :json)
end
