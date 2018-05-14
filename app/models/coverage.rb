class Coverage < ApplicationRecord
  has_paper_trail meta: { template_id: ->(cvg) { cvg.package.template.id }, dealership_id: ->(cvg) { cvg.package.template.dealership.id } }

  belongs_to :package

  validates :length_in_months, presence: true, numericality: { greater_than: 0, allow_nil: true }
  validates :limit_in_miles, presence: true, numericality: { greater_than: 0, allow_nil: true }
  # validates :cost_in_cents, presence: true, numericality: { greater_than: 0, allow_nil: true }
end
