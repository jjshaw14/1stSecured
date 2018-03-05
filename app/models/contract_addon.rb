class ContractAddon < ApplicationRecord
  has_paper_trail meta: { contract_id: :contract_id, dealership_id: ->(addon) { addon.contract.dealership.id } }

  belongs_to :contract
  belongs_to :addon
end
