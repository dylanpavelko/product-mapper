class NativeIssueHasResponse < ActiveRecord::Base
  belongs_to :native_issue, class_name: "NativeIssue", foreign_key: "native_issue_id"
  belongs_to :response
end
