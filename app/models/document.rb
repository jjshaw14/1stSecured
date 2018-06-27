class Document < ApplicationRecord
  belongs_to :dealership

  mount_base64_uploader :attachment, AttachmentUploader, file_name: ->(d) { [d.dealership.name, d.name].join(' ').parameterize }
end
