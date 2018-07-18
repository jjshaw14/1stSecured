class AddOrderToAddons < ActiveRecord::Migration[5.1]
  def change
    add_column :addons, :order, :integer
    Package.all.each{|p|
      i = 0
      p.addons.each{|a|
        a.order = i
        i += 1
        a.save
      }
    }
  end
end
