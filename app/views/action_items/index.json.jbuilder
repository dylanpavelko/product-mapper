json.array!(@action_items) do |action_item|
  json.extract! action_item, :id, :name, :description, :complete, :completed, :due_override, :due_by_meeting_id, :action_from_agenda_item_id
  json.url action_item_url(action_item, format: :json)
end
