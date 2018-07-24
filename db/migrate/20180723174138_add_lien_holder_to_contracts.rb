class AddLienHolderToContracts < ActiveRecord::Migration[5.1]
  def change
    add_column :contracts, :lien_holder, :string
  end
end
