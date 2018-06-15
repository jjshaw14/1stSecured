class AddFeeInCentsToAddon < ActiveRecord::Migration[5.1]
  def change
    add_column :addons, :fee_in_cents, :integer, default: 0
  end
end
