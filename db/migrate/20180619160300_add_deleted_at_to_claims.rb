class AddDeletedAtToClaims < ActiveRecord::Migration[5.1]
  def change
    add_column :claims, :deleted_at, :timestamp
    add_column :claims, :shop_name, :string
    add_column :claims, :shop_phone, :string
    add_column :claims, :shop_address, :string
    add_column :claims, :shop_rep, :string
    add_column :claims, :shop_notes, :text
    add_column :claims, :authorized_at, :timestamp
    add_column :claims, :repaired_at, :timestamp
    add_column :claims, :notes, :text
    add_column :claims, :can_it_be_safely_moved, :boolean
  end
end
