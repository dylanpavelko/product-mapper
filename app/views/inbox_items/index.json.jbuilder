json.array!(@inbox_items) do |inbox_item|
  json.extract! inbox_item, :id, :user_id, :activity_id, :read
  json.url inbox_item_url(inbox_item, format: :json)
end
