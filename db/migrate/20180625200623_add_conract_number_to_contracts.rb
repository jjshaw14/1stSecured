class AddConractNumberToContracts < ActiveRecord::Migration[5.1]
  def change
    add_column :contracts, :contract_number, :string
  end
end
