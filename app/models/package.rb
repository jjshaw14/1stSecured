class Package < ApplicationRecord
  has_paper_trail meta: { template_id: :template_id, dealership_id: ->(pkg) { pkg.template.dealership.id } }

  belongs_to :template
  has_many :coverages, autosave: true
  has_many :addons, autosave: true

  def has_coverage_caveats?
    coverages.map(&:caveat).select(&:present?).any?
  end
end
