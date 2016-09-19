class NativeIssue < ActiveRecord::Base
  include PublicActivity::Common
  

  belongs_to :issue_with, class_name: "Node", foreign_key: "issue_with_id"
  belongs_to :resolved_with, class_name: "Node", foreign_key: "resolved_with_id"
  belongs_to :added_by, class_name: "User", foreign_key: "added_by_id"

  attr_accessor :asana_id
  attr_accessor :asana_url
  attr_accessor :asana_workspace_id
  attr_accessor :asana_name

  validates :added_by, :presence => true
  validates :summary, :presence => true

  scope :added_by, -> (added_by) { where added_by: added_by }
  scope :after, -> (after_date) {where ["created_at >= ?", Date.strptime(after_date, '%Y-%m-%d')]}
  scope :before, -> (before_date) { where ["created_at <= ?", Date.strptime(before_date, '%Y-%m-%d')] }

  def status
    status = "Open"
    if self.close_without_resolution
      status = "Closed"
    elsif resolved_with != nil and resolved_with.status
      status = "Done"
    end
    return status
  end

  def customer_impacts
    @issue_impacts = NativeIssueHasImpact.where(:native_issue_id => self.id)
  end

  def has_impact_text_for_customer(customer_id)
    @impact = NativeIssueHasImpact.where(:native_issue_id => self.id, :customer_id => customer_id).first
    if @impact != nil
      return @impact.impact_text
    end
  end

  def has_priority_for_customer(customer_id)
    @impact = NativeIssueHasImpact.where(:native_issue_id => self.id, :customer_id => customer_id).first
    if @impact != nil
      return @impact.priority
    end
  end
end
