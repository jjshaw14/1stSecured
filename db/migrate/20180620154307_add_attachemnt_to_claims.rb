class AddAttachemntToClaims < ActiveRecord::Migration[5.1]
  def change
    add_column :claims, :attachment, :string
  end
end
