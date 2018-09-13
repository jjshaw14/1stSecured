class RenameDealershipTimelapsedDataPointsToTimelapsedDataPoints < ActiveRecord::Migration[5.1]
  def change
    rename_table :dealership_timelapsed_data_points, :timelapsed_data_points
  end
end
