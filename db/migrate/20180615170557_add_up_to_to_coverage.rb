class AddUpToToCoverage < ActiveRecord::Migration[5.1]
  def change
    add_column :coverages, :up_to, :boolean, default: false
  end
end
