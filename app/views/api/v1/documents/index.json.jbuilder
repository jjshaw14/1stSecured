json.array! @documents do |document|
  json.id document.id
  json.name document.name
  json.attachment "/api/v1/documents/#{document.id}/attachment" if document.attachment.file.present?
  json.url document.attachment.url if document.attachment.url.present?
end
