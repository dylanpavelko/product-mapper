class Milestone < ActiveRecord::Base
  has_many :capacities, class_name: "Capacity", foreign_key: "milestone_id"
  
  def has_capacity_for_efforts(efforts, capacities_amounts)
    efforts.each do |effort|
      @capacity = capacities_amounts.select { |capacity| capacity.team == effort.team} 
      if @capacity.count == 0 || @capacity[0].get_remaining_capacity < effort.amount
        return false
      end
    end
    return true
  end
end
