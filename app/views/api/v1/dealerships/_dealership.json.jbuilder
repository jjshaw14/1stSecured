json.id dealership.id
json.name dealership.name

json.address1 dealership.address1
json.address2 dealership.address2
json.address3 dealership.address3
json.city dealership.city
json.state dealership.state
json.zip dealership.zip

json.performance do
  json.costs dealership.contracts.joins(:coverage).sum('coverages.cost_in_cents')
  json.claims dealership.contracts.joins(:claims).sum('claims.cost_in_cents')
  json.fees dealership.contracts.sum('fee_in_cents')
end

json.templates dealership.templates, partial: 'api/v1/templates/template', as: :template
json.users dealership.users, partial: 'api/v1/users/user', as: :user

json.created_at dealership.created_at
json.updated_at dealership.updated_at
