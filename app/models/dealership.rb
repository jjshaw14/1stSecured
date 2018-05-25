class Dealership < ApplicationRecord
  has_paper_trail meta: { dealership_id: :id }

  include HasAddress

  has_many :contracts
  has_many :claims, through: :contracts
  has_many :templates
  has_many :users

  validates :name, presence: true
  validates :address1, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip, presence: true
  def default_terms
    DEFAULT_TERMS
  end
end
