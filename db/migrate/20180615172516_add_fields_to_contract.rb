class AddFieldsToContract < ActiveRecord::Migration[5.1]
  def change
    add_column :contracts, :cost_in_cents, :integer
    add_column :contracts, :limit_in_miles, :integer
    add_column :contracts, :length_in_months, :integer
    add_column :contracts, :up_to, :boolean
    add_column :contracts, :varchar_template, :text

    Contract.all.each do |c|
      c.cache_values_from_template
      c.save!
    end
  end
end
