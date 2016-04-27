class JiraIssue < ActiveRecord::Base
  belongs_to :jira_repo
end
