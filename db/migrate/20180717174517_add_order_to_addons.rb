class AddOrderToAddons < ActiveRecord::Migration[5.1]
  def change
    add_column :addons, :order, :integer
    Package.all.each{|p|
      p.addons.each.with_index{|a, i|
        a.order = i
        a.save
      }
    }
  end
end
