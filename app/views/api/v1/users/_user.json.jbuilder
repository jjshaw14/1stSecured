json.id user.id
json.first_name user.first_name
json.last_name user.last_name
json.email user.email
if user.dealership.present?
  json.dealership do
    json.id user.dealership.id
    json.name user.dealership.name
  end
  json.user_type user.user_type
end

json.created_at user.created_at
json.updated_at user.updated_at
