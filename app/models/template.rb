class Template < ApplicationRecord
  has_paper_trail meta: { template_id: :id, dealership_id: :dealership_id }

  belongs_to :dealership
  has_many :packages, autosave: true
end
