class Contract < ApplicationRecord
  has_paper_trail meta: { contract_id: :id, dealership_id: :dealership_id }

  include HasAddress

  before_save :lookup_info_by_vin!
  before_save :refresh_fee

  belongs_to :dealership
  belongs_to :template
  belongs_to :created_by, class_name: 'User'
  belongs_to :submitted_by, class_name: 'User', optional: true

  has_many :contract_addons

  belongs_to :coverage, optional: true
  has_many :addons, through: :contract_addons

  has_many :claims

  validates :first_name, presence: true
  validates :last_name, presence: true

  validates :stock_number, presence: true
  validates :vin, presence: true
  validates :purchased_on, presence: true
  validates :odometer, presence: true, numericality: { greater_than: 0, allow_nil: true }

  validates :address1, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip, presence: true
  delegate :terms, to: :template
  mount_base64_uploader :signed_copy, SignedCopyUploader, file_name: ->(c) { [c.id, c.first_name, c.last_name].join(' ').parameterize }
  scope :this_month, -> {
    where('purchased_on > ? ', Date.today.at_beginning_of_month)
  }
  pg_search_scope :search_for, against: %i[first_name last_name make model year], using: { tsearch: { prefix: true } }

  scope :loss_ratio, (lambda do
    term   = '((SUM(coverages.length_in_months) / 12.0) * 365)'
    matured = 'SUM(current_date - purchased_on)'
    claims = 'SUM(COALESCE(claims.cost_in_cents, 0))'
    costs  = '(SUM(coverages.cost_in_cents) + SUM(COALESCE(addons.cost_in_cents, 0))) * 100'
    left_joins(:claims).left_joins(:coverage).left_joins(:addons)
    .select("ROUND(((#{term} / #{matured}) * #{claims}) / #{costs}, 2) AS loss_ratio")
    .to_a.first.loss_ratio || '100.00'
  end)

  def matures_on
    coverage && created_at + coverage.length_in_months.months
  end

  def price
    price_in_cents / 100.00 if price_in_cents.present?
  end

  protected

  def lookup_info_by_vin!
    data = VinLookupService.new.execute(vin)
    self.make ||= data[:make]
    self.model ||= data[:model]
    self.year ||= data[:year]
  end

  def refresh_fee
    self.fee_in_cents = Fee.find_from_coverage(coverage).cost_in_cents
  end
end
