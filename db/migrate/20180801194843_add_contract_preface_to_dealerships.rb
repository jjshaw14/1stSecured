class AddContractPrefaceToDealerships < ActiveRecord::Migration[5.1]
  def change
    add_column :dealerships, :contract_preface, :string, default: ''
  end
end