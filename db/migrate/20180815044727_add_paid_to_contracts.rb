class AddPaidToContracts < ActiveRecord::Migration[5.1]
  def change
  	add_column :contracts, :paid, :boolean, default: false
  end
end
