class CreateDealershipTimelapsedDataPoints < ActiveRecord::Migration[5.1]
  def change
    create_table :dealership_timelapsed_data_points do |t|
      t.integer :data_type
      t.integer :value
      t.integer :month
      t.integer :year
      t.integer :week
      t.belongs_to :dealership, foreign_key: true
      t.timestamp :run_at
    end
  end
end
