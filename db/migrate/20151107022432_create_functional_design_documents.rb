class CreateFunctionalDesignDocuments < ActiveRecord::Migration
  def change
    create_table :functional_design_documents do |t|
      t.string :name
      t.string :url

      t.timestamps
    end
  end
end
