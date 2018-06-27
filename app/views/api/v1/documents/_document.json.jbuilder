json.name document.name
json.id document.id
json.attachment "/api/v1/documents/#{document.id}/attachment" if document.attachment.file.present?
json.dealership do
  json.name document.dealership.name
  json.id document.dealership.id
end
