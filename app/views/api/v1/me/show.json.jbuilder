json.id current_user.id

json.first_name current_user.first_name
json.last_name current_user.last_name
json.email current_user.email
json.user_type current_user.user_type
if current_user.dealership.present?
  json.dealership do
    json.id current_user.dealership.id
    json.name current_user.dealership.name
    json.users current_user.dealership.users, partial: 'api/v1/users/user', as: :user
    json.performance { json.partial! 'api/v1/dealerships/performance', locals: { dealership: current_user.dealership } }
    if current_user.dealership.templates.without_deleted.present?
      json.templates current_user.dealership.templates.without_deleted.map{|template| {name: template.name, id: template.id }  }
    end
    if current_user.dealership.documents.without_deleted.present?
      json.documents current_user.dealership.documents.without_deleted.map{|document|
        {
          name: document.name,
          id: document.id,
          attachment: document.attachment.file.present? ?
            "/api/v1/documents/#{document.id}/attachment" :
            nil
        }
      }
    end
  end
end
