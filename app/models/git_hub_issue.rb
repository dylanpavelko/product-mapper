class GitHubIssue < ActiveRecord::Base
  belongs_to :node
  belongs_to :repo

  def resolved_with
  	return nil
  end
end
