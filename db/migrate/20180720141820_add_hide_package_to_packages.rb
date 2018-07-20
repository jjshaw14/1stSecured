class AddHidePackageToPackages < ActiveRecord::Migration[5.1]
  def change
    add_column :packages, :hide_package, :boolean
  end
end
