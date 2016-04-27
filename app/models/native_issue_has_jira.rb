class NativeIssueHasJira < ActiveRecord::Base
  belongs_to :jira
  belongs_to :native_issue
end
