json.dealership_id @dealership.id
json.claims @dealership
  .timelapsed_data_points
  .claims
  .order(:year, :month)
  .select(:year,:month,:value)
json.contracts @dealership
  .timelapsed_data_points
  .contracts
  .order(:year, :month)
  .select(:year,:month,:value)
json.reserves @dealership
  .timelapsed_data_points
  .reserves
  .select(:run_at, :value).order(:run_at)

json.contracts_this_month @dealership.contracts.without_deleted.this_month.count
