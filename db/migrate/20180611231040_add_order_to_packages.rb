class AddOrderToPackages < ActiveRecord::Migration[5.1]
  def change
    add_column :packages, :order, :integer
    Template.all.each {|t|
      t.packages.each.with_index {|p,i|
        p.order = i
        p.save
      }
    }
  end
end
