class RemoveCostInCentsFromFees < ActiveRecord::Migration[5.1]
  def change
    remove_column :fees, :cost_in_cents, :integer
  end
end
