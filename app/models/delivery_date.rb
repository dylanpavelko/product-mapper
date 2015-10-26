class DeliveryDate < ActiveRecord::Base
  belongs_to :node, class_name: "Node", foreign_key: "node_id"
  belongs_to :environment, class_name: "Environment", foreign_key: "envrionment_id"
  belongs_to :milestone, class_name: "Milestone", foreign_key: "milestone_id"

  def delivery_type
  	if self.target_type == 1
  		return "Targeted to"
  	elsif self.target_type == 2
  		return "Delivered to"
  	elsif self.target_type == 3
  		return "Deprecated in"
  	end
  end

  def delivery_type_short
    if self.target_type == 1
      return "Targeted to"
    elsif self.target_type == 2
      return "Delivered in"
    elsif self.target_type == 3
      return "Deprecated in"
    end
  end

  def string
    return self.delivery_type + " " + self.environment.name + " with " + self.milestone.name
  end

  def short_string
    return self.delivery_type_short + " " + self.milestone.name
  end

end
