json.id current_user.id

json.first_name current_user.first_name
json.last_name current_user.last_name
json.email current_user.email

if current_user.dealership.present?
  json.dealership do
    json.id current_user.dealership.id
    json.name current_user.dealership.name
    json.performance { json.partial! 'api/v1/dealerships/performance', locals: { dealership: current_user.dealership } }
    if current_user.dealership.templates.present?
      json.templates current_user.dealership.templates.map{|template| {name: template.name, id: template.id }  }
    end
  end
end
