class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  include PgSearch

  def self.find_or_initialize_by_params(params)
    id = params.delete(:id)
    @record = find_by(id: id) || new
    @record.assign_attributes params
    @record
  end

  scope :available_to, ->(user) { user.dealership ? where(dealership: user.dealership) : all }
  scope :without_deleted, -> { where(deleted_at: nil)    }
end
