class AddDeletedAtToContracts < ActiveRecord::Migration[5.1]
  def change
    add_column :contracts, :deleted_at, :timestamp
  end
end
