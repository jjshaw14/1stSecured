class Dealership < ApplicationRecord
  has_paper_trail meta: { dealership_id: :id }

  include HasAddress

  has_many :documents
  has_many :contracts
  has_many :claims, through: :contracts
  has_many :templates
  has_many :users
  has_many :timelapsed_data_points

  validates :name, presence: true
  validates :address1, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip, presence: true
  def default_terms
    DEFAULT_TERMS
  end
  scope :available_to, -> (user) {
    user.dealership_id ? where(id: user.dealership_id) : all
  }
  before_save :format_phone_number
  def next_contract_number
    contract_number = contract_preface + '-' + (1000 + contracts.count).to_s
  end
  private
  def format_phone_number
    phone = phone &.gsub(/[^\d]/, '')
  end
end
