class AddColumnsToClaim < ActiveRecord::Migration[5.1]
  def change
    add_column :claims, :location, :string
    add_column :claims, :issue, :text
  end
end
