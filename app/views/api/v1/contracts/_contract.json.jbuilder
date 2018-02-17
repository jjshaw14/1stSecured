json.id contract.id

json.dealership do
  json.id contract.dealership.id
  json.name contract.dealership.name
end

json.first_name contract.first_name
json.last_name contract.last_name

json.vin contract.vin
json.make contract.make
json.model contract.model
json.year contract.year
json.odometer contract.odometer
json.purchased_on contract.purchased_on

json.address1 contract.address1
json.address2 contract.address2
json.address3 contract.address3
json.city contract.city
json.state contract.state
json.zip contract.zip

json.coverage do
  json.id contract.coverage.id
  json.name contract.coverage.limit_in_miles
end unless contract.coverage.nil?

json.addons contract.addons, partial: 'api/v1/addons/addon', as: :addon

json.template contract.template, partial: 'api/v1/templates/template', as: :template

json.created_at contract.created_at
json.updated_at contract.updated_at
