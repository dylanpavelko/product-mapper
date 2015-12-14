class AddPresentedToNodeHasFunctionalDesignDocuments < ActiveRecord::Migration
  def change
    add_column :node_has_functional_design_documents, :presented, :date
  end
end
