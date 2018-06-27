class CreateDocuments < ActiveRecord::Migration[5.1]
  def change
    create_table :documents do |t|
      t.belongs_to :dealership, foreign_key: true
      t.string :name
      t.string :attachment
    end
  end
end
