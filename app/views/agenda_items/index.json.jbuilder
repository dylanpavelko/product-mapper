json.array!(@agenda_items) do |agenda_item|
  json.extract! agenda_item, :id, :name, :meeting_id, :order
  json.url agenda_item_url(agenda_item, format: :json)
end
