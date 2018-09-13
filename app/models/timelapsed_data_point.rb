class TimelapsedDataPoint < ApplicationRecord

  belongs_to :dealership
  enum data_type: {
    claims: 0,
    contracts: 1,
    reserves: 2
  }
end
