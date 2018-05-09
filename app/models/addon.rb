class Addon < ApplicationRecord
  has_paper_trail meta: {
    template_id: ->(addon) { addon.package.template.id },
    dealership_id: ->(addon) { addon.package.template.dealership.id }
  }

  belongs_to :package

  def cost_in_dollars
    cost_in_cents && (cost_in_cents / 100)
  end

  def price_in_dollars
    price_in_cents && (price_in_cents / 100)
  end
end
