class NodeType < ActiveRecord::Base
	has_many :nodes

	def self.all_without_marker
		NodeType.where(:marker => nil) + NodeType.where(:marker => false)
	end
end
