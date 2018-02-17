class Addon < ApplicationRecord
  belongs_to :package

  def amount_in_dollars
    amount_in_cents && (amount_in_cents / 100)
  end
end
