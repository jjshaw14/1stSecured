json.id template.id
json.name template.name

json.dealership do
  json.id template.dealership.id
  json.name template.dealership.name
end

json.packages template.packages, partial: 'api/v1/packages/package', as: :package

json.created_at template.created_at
json.updated_at template.updated_at
