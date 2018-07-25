json.array! @contracts do |contract|
  json.id contract.id

  json.dealership do
    json.id contract.dealership.id
    json.name contract.dealership.name
  end

  json.first_name contract.first_name
  json.last_name contract.last_name
  json.cost contract.cost
  json.vin contract.vin
  json.make contract.make
  json.model contract.model
  json.year contract.year
  json.odometer contract.odometer
  json.purchased_on contract.purchased_on
  json.matured contract.matured
  json.created_at contract.created_at
  json.updated_at contract.updated_at
end
