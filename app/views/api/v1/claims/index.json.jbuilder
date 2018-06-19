json.array! @claims do |claim|
  json.id claim.id
  json.contract do
    json.id claim.contract.id
    json.first_name claim.contract.first_name
    json.last_name claim.contract.last_name
    json.vin claim.contract.vin
    json.model claim.contract.model
    json.year claim.contract.year
    json.purchased_on claim.contract.purchased_on
  end
  json.cost format('%.2f', (claim.cost_in_cents / 100.0))
  json.created_at claim.created_at
  json.updated_at claim.updated_at
end
