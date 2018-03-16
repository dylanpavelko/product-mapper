class ActionItem < ActiveRecord::Base
  belongs_to :due_by_meeting, class_name: "Meeting"
  belongs_to :action_from_agenda_item, class_name: "AgendaItem"
end
