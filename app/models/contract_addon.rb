class ContractAddon < ApplicationRecord
  has_paper_trail meta: { contract_id: :contract_id, dealership_id: ->(addon) { addon.contract.dealership.id } }

  belongs_to :contract
  belongs_to :addon
  after_create :increase_contract_cost
  after_destroy :decrease_contract_cost
  def increase_contract_cost
    contract.cost_in_cents = contract.cost_in_cents + addon.cost_in_cents
    contract.save
  end

  def decrease_contract_cost
    contract.cost_in_cents = contract.cost_in_cents - addon.cost_in_cents
    contract.save
  end
end
