class Package < ApplicationRecord
  belongs_to :template
  has_many :coverages
  has_many :addons

  def has_coverage_caveats?
    coverages.map(&:caveat).select(&:present?).any?
  end
end
