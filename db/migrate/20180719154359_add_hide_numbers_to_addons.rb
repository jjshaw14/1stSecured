class AddHideNumbersToAddons < ActiveRecord::Migration[5.1]
  def change
    add_column :addons, :hide_numbers, :boolean
  end
end
