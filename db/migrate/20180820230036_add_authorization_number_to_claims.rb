class AddAuthorizationNumberToClaims < ActiveRecord::Migration[5.1]
  def change
    add_column :claims, :authorization_number, :string
  end
end
