class NativeIssueHasJira < ActiveRecord::Base
  belongs_to :jira, class_name: "JiraIssue", foreign_key: "jira_id"
  belongs_to :native_issue, class_name: "NativeIssue", foreign_key: "native_issue_id"
end
