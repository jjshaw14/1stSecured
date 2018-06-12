class Coverage < ApplicationRecord
  has_paper_trail meta: { template_id: ->(cvg) { cvg.template.id if cvg.template }, dealership_id: ->(cvg) { cvg.dealership_id if cvg.template} }

  belongs_to :package
  delegate :template, :dealership_id,:dealership, to: :package
  validates :length_in_months, presence: true, numericality: { greater_than: 0, allow_nil: true }
  validates :limit_in_miles, presence: true, numericality: { greater_than: 0, allow_nil: true }
  # validates :cost_in_cents, presence: true, numericality: { greater_than: 0, allow_nil: true }
end
