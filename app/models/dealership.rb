class Dealership < ApplicationRecord
  include HasAddress

  has_many :contracts
  has_many :templates
  has_many :users

  validates :name, presence: true
  validates :address1, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip, presence: true
end
