class AddOrderToAddons < ActiveRecord::Migration[5.1]
  def change
    add_column :addons, :order, :integer
  end
end
