class CountContractsByMonthJob < ApplicationJob
  def perform(dealership, month, year)
    Dealerships::CreateMonthlyCount.new(dealership, month, year, :contracts).call
  end
end
