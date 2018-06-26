class Contract < ApplicationRecord
  has_paper_trail meta: { contract_id: :id, dealership_id: :dealership_id }

  include HasAddress

  before_save :lookup_info_by_vin!
  before_save :cache_values_from_template

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
  scope :without_deleted, -> {
    where(deleted_at: nil)
  }
  scope :loss_ratio, (lambda do
    term   = '((SUM(length_in_months) / 12.0) * 365)'
    maturity = '(case
                SUM(current_date - purchased_on) when 0 then 1
                else SUM(current_date - purchased_on) end)'
    claims = 'SUM(COALESCE(claims.cost_in_cents / 100, 0))'
    costs  = '(SUM(contracts.cost_in_cents / 100))'
    joins('left outer join claims on claims.contract_id = contracts.id and claims.deleted_at is null')
    .select("ROUND( ( ( (#{maturity} / #{term} ) * #{costs}) - #{claims}) / #{costs}, 2) AS loss_ratio")
    .without_deleted
    .to_a.first.loss_ratio || '100.00'
  end)

  def matures_on
    created_at + (length_in_months || 0).months
  end
  def cost
    cost_in_cents / 100.00 if cost_in_cents.present?
  end
  def price
    price_in_cents ? price_in_cents / 100.00 : 0.00
  end
  def cached_template
    @cached_template ||= varchar_template ? OpenStruct.new(JSON.parse(varchar_template)).tap{|template|
      template.coverages = template.coverages.is_a?(String) ?
        JSON.parse(template.coverages).map{|coverage|
          OpenStruct.new(coverage)
      } : template.coverages.map{|c| OpenStruct.new(c) }

      template.addons = template.addons.is_a?(String) ?
        JSON.parse(template.addons).map{
          OpenStruct.new(addon)
      } : template.addons.map{|a| OpenStruct.new(a) }

      template.packages = template.packages.is_a?(String) ?
        JSON.parse(template.packages).map{|package|
        OpenStruct.new(package).tap{|package|
          package['coverage_caveats?'] = template.coverages.any?{|coverage| coverage.caveat }
        }

      } : template.packages.map{|p| OpenStruct.new(p) }

      template.packages.map{|package|
        package.addons = template.addons.select{|addon| addon.package_id == package.id }
        package.coverages = template.coverages.select{|coverage| coverage.package_id == package.id }
      }
    }: template
  end

  def cache_values_from_template
    self.varchar_template = template.attributes.tap{|json_template|
      json_template['packages']  = template.packages.to_json
      json_template['coverages'] = template.packages.flat_map(&:coverages)
      json_template['addons'] = template.packages.flat_map(&:addons)
    }.to_json

    self.limit_in_miles = coverage.limit_in_miles
    self.length_in_months = coverage.length_in_months
    self.up_to = coverage.up_to
    self.fee_in_cents = coverage.fee_in_cents + addons.reload.sum('fee_in_cents')
    self.cost_in_cents = coverage.cost_in_cents + addons.reload.sum('cost_in_cents')
  end
  def length_in_months_or_years
    if length_in_months
      length_in_months < 12 ?
        length_in_months.to_s + ' months' :
        (length_in_months / 12).to_s  + ' years'
    else
      nil
    end
  end
  def miles_matured_on
    up_to ? limit_in_miles : limit_in_miles + odometer
  end
  def claims_cost
    "$" << format('%.2f', claims.without_deleted.sum(:cost_in_cents)  / 100.0)
  end
  protected
  def lookup_info_by_vin!
    data = VinLookupService.new.execute(vin)
    self.make ||= data[:make]
    self.model ||= data[:model]
    self.year ||= data[:year]
  end
end
