class InboxItem < ActiveRecord::Base
  belongs_to :user, class_name: "User", foreign_key: "user_id"
  

  def activity
  	return  PublicActivity::Activity.where(id: self.activity_id).first

  end
end
