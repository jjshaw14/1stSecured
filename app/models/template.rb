class Template < ApplicationRecord
  belongs_to :dealership
  has_many :packages, autosave: true
end
