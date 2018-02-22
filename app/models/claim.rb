class Claim < ApplicationRecord
  belongs_to :contract
  belongs_to :provider, class_name: 'ServiceProvider'

  validates :cost_in_cents, numericality: { greater_than: 0 }
  validates :odometer, numericality: { greater_than: 0 }
end
