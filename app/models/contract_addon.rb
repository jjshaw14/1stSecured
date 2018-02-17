class ContractAddon < ApplicationRecord
  belongs_to :contract
  belongs_to :addon
end
