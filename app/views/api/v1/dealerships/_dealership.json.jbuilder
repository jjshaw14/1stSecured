json.id dealership.id
json.name dealership.name
json.default_terms dealership.default_terms
json.address1 dealership.address1
json.address2 dealership.address2
json.address3 dealership.address3
json.city dealership.city
json.state dealership.state
json.zip dealership.zip
json.phone dealership.phone
json.performance { json.partial! 'performance', locals: { dealership: dealership } }

json.templates dealership.templates.where(deleted_at: nil), partial: 'api/v1/templates/template', as: :template
json.users dealership.users, partial: 'api/v1/users/user', as: :user
json.phone_number number_to_phone(dealership.phone, area_code: true)
json.created_at dealership.created_at
json.updated_at dealership.updated_at
