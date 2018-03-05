class Coverage < ApplicationRecord
  has_paper_trail meta: { template_id: ->(cvg) { cvg.package.template.id }, dealership_id: ->(cvg) { cvg.package.template.dealership.id } }

  belongs_to :package
end
