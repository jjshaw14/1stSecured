class AddDeletedAtToTemplates < ActiveRecord::Migration[5.1]
  def change
    add_column :templates, :deleted_at, :timestamp
  end
end
