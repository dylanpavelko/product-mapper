class GitHubIssue < ActiveRecord::Base
  belongs_to :node
  belongs_to :repo
end
