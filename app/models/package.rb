class Package < ApplicationRecord
  belongs_to :template
  has_many :coverages, autosave: true
  has_many :addons, autosave: true

  def has_coverage_caveats?
    coverages.map(&:caveat).select(&:present?).any?
  end
end
