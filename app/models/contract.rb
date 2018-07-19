class Contract < ApplicationRecord
  has_paper_trail meta: { contract_id: :id, dealership_id: :dealership_id }

  include Contractable

  class LprHelper
    @term = '((sum(length_in_months) / 12.0) * 365)'
    @maturity = 'sum(current_date - purchased_on)'
    @claims = 'sum(coalesce(claims.cost_in_cents, 0))'
    @costs = '(sum(contracts.cost_in_cents))'
    class << self
      def lpr
        "round( ( #{term_over_maturity_with_cap} * #{@claims}) / #{safe(@costs)}, 4) * 100"
      end
      def maturity
        "( #{maturity_over_term_with_cap} * #{@costs} / 100 )"
      end
      def matured_without_claims
          "round(#{maturity}, 2)"
      end
      def matured
          "round(( #{maturity} - #{@claims} / 100), 2)"
      end
      private
      def safe method
        "(case #{method} when 0 then 1 else #{method} end)"
      end
      def maturity_over_term
        " (#{@maturity} / #{@term}) "
      end
      def term_over_maturity
        " (#{@term} / #{safe(@maturity)}) "
      end
      def maturity_over_term_with_cap
        "(case when #{maturity_over_term} >= 1 then 1 else #{maturity_over_term} end)"
      end
      def term_over_maturity_with_cap
        "(case when #{term_over_maturity} <= 1 then 1 else #{term_over_maturity} end)"
      end
    end
  end
  include HasAddress

  before_save :lookup_info_by_vin!
  before_save :cache_values_from_template

  belongs_to :dealership
  belongs_to :template
  belongs_to :created_by, -> {unscope(where: :deleted_at) }, class_name: 'User'
  belongs_to :submitted_by, class_name: 'User', optional: true

  has_many :contract_addons

  belongs_to :coverage, optional: true
  has_many :addons, through: :contract_addons

  has_many :claims

  validates :first_name, presence: true
  validates :last_name, presence: true

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
  pg_search_scope :search_for, against: %i[first_name last_name make model year contract_number], using: { tsearch: { prefix: true } }
  scope :with_claims_this_month, -> {
    self.where(id: Contract.joins(:claims).where('claims.authorized_at > ?', Date.today.at_beginning_of_month).where(claims: {deleted_at: nil}).map(&:id))
  }
  def self.performance
    joins('left outer join claims on claims.contract_id = contracts.id and claims.deleted_at is null')
      .without_deleted
      .select("#{LprHelper.lpr} as loss_ratio,
              #{LprHelper.matured} as matured_with_claims,
              #{LprHelper.matured_without_claims} as matured_without_claims")[0]
  end
  def self.loss_ratio
    joins('left outer join claims on claims.contract_id = contracts.id and claims.deleted_at is null')
      .select("#{LprHelper.lpr} AS loss_ratio")[0].loss_ratio || '100.00'
  end
  def self.matured
    joins('left outer join claims on claims.contract_id = contracts.id and claims.deleted_at is null')
      .select("#{LprHelper.matured} AS m")[0].m
  end
  def matures_on
    purchased_on ? (purchased_on + (length_in_months || 0).months ) : Date.today
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

  def miles_matured_on
    if up_to
      limit_in_miles
    else
      if limit_in_miles
        limit_in_miles + odometer
      else
        nil
      end
    end
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
