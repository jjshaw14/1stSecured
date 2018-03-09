class Fee < ApplicationRecord
  validates :length_in_months, presence: true, numericality: { greater_than: 0, allow_nil: true }
  validates :cost_in_cents, presence: true, numericality: { greater_than: 0, allow_nil: true }

  def self.find_from_coverage(coverage)
    find_by(length_in_months: coverage.length_in_months)
  end

  def self.viewable_by?(user)
    true
  end
end
