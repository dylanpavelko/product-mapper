class JiraIssue < ActiveRecord::Base
  belongs_to :jira_repo

  validates :summary, :presence => true

  def url
  	return self.jira_repo.url + "/browse/" + self.key
  end
end
