class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  include PgSearch

  def self.find_or_initialize_by_params(params)
    id = params.delete(:id)
    @record = find_by(id: id) || new
    @record.assign_attributes params
    @record
  end
end
