class AddOrderToCoverages < ActiveRecord::Migration[5.1]
  def change
    add_column :coverages, :order, :integer
    Package.all.each{|p|
      p.coverages.each.with_index {|c, i|
        c.order = i
        c.save
      }
    }
  end
end
