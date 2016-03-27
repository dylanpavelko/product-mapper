class UserHasRoleForNode < ActiveRecord::Base
  belongs_to :user, class_name: "User", foreign_key: "user_id"
  belongs_to :role, class_name: "Role", foreign_key: "role_id"
  belongs_to :node

  public
  def subscribes_to(activity)
	return self.role.subscribes
  end
end
