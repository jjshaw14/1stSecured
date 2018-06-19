class AddUpdatedOdometerToContracts < ActiveRecord::Migration[5.1]
  def change
    add_column :contracts, :updated_odometer, :integer
  end
end
