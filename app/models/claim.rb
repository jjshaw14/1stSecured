class Claim < ApplicationRecord
  has_paper_trail meta: { contract_id: :contract_id, dealership_id: ->(claim) { claim.contract.dealership.id } }

  belongs_to :contract
  belongs_to :provider, optional: true, class_name: 'ServiceProvider'
  scope :this_month, -> {
    where('claims.created_at > ?', Date.today.at_beginning_of_month)
  }
  scope :by_dealership, -> (dealership) {
    joins(:contract => :dealership).where(dealerships: {id: dealership.id})
  }
  validates :cost_in_cents, numericality: { greater_than: 0, allow_nil: true }
  validates :odometer, numericality: { greater_than: 0 }
end
