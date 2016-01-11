class NativeIssueHasAsana < ActiveRecord::Base
  belongs_to :asana_task
  belongs_to :native_issue
end
