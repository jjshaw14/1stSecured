json.id dealership.id
json.name dealership.name

json.address1 dealership.address1
json.address2 dealership.address2
json.address3 dealership.address3
json.city dealership.city
json.state dealership.state
json.zip dealership.zip

json.performance { json.partial! 'performance', locals: { dealership: dealership } }

json.templates dealership.templates, partial: 'api/v1/templates/template', as: :template
json.users dealership.users, partial: 'api/v1/users/user', as: :user

json.created_at dealership.created_at
json.updated_at dealership.updated_at
