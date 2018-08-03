json.id template.id
json.name template.name

json.dealership do
  json.id template.dealership.id
  json.name template.dealership.name
  json.contract_number template.dealership.next_contract_number
end
json.dealership_id template.dealership_id
json.packages template.packages.order(:order), partial: 'api/v1/packages/package', as: :package
json.terms template.terms
json.created_at template.created_at
json.updated_at template.updated_at
