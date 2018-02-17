class Contract < ApplicationRecord
  include HasAddress

  before_save :lookup_info_by_vin!

  belongs_to :dealership
  belongs_to :template
  belongs_to :created_by, class_name: 'User'
  belongs_to :submitted_by, class_name: 'User', optional: true

  validates :first_name, presence: true
  validates :last_name, presence: true

  validates :vin, presence: true
  validates :purchased_on, presence: true
  validates :odometer, presence: true, numericality: { greater_than: 0 }

  validates :address1, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip, presence: true

  has_many :contract_addons

  belongs_to :coverage, optional: true
  has_many :addons, through: :contract_addons

  pg_search_scope :search_for, against: %i(first_name last_name make model year), using: { tsearch: { prefix: true } }

  protected

  def lookup_info_by_vin!
    data = VinLookupService.new.execute(vin)
    self.make ||= data[:make]
    self.model ||= data[:model]
    self.year ||= data[:year]
  end
end
