class AddDeletedAtToDealerships < ActiveRecord::Migration[5.1]
  def change
    add_column :dealerships, :deleted_at, :timestamp
  end
end
