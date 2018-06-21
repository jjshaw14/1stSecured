class Claim < ApplicationRecord
  has_paper_trail meta: { contract_id: :contract_id, dealership_id: ->(claim) { claim.contract.dealership.id } }

  belongs_to :contract
  belongs_to :provider, optional: true, class_name: 'ServiceProvider'
  scope :this_month, -> {
    where('claims.created_at > ?', Date.today.at_beginning_of_month)
  }
  scope :by_dealership, -> (dealership) {
    joins(:contract => :dealership).where(dealerships: {id: dealership.id})
  }
  scope :without_deleted, -> {
    where(deleted_at: nil) }
  validates :cost_in_cents, numericality: { greater_than: 0, allow_nil: true }
  validates :odometer, numericality: { greater_than: 0 }
  after_save :update_odometer_on_contract

  mount_base64_uploader :attachment, ClaimAttachmentUploader, file_name: ->(c) { [c.id, c.contract.first_name, c.contract.last_name].join(' ').parameterize }
  scope :available_to, ->(current_user) {
    current_user.dealership.present? ?
      joins(:contract).where(contracts: {dealership_id: current_user.dealership.id}) :
      all }
  def cost
    format('%.2f', (cost_in_cents / 100.0))
  end
  private
  def update_odometer_on_contract
    contract.updated_odometer = odometer if odometer
    contract.save
  end
end
