class Addon < ApplicationRecord
  has_paper_trail meta: { template_id: ->(addon) { addon.package.template.id }, dealership_id: ->(addon) { addon.package.template.dealership.id } }

  belongs_to :package

  def amount_in_dollars
    amount_in_cents && (amount_in_cents / 100)
  end
end
