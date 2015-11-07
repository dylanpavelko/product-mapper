class CreateNodeHasFunctionalDesignDocuments < ActiveRecord::Migration
  def change
    create_table :node_has_functional_design_documents do |t|
      t.references :node, index: true
      t.references :FDD, index: true

      t.timestamps
    end
  end
end
