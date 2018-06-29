class AddDeleteAtToDocuments < ActiveRecord::Migration[5.1]
  def change
    add_column :documents, :deleted_at, :timestamp
  end
end
