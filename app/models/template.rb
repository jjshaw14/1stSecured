class Template < ApplicationRecord
  belongs_to :dealership
  has_many :packages
end
