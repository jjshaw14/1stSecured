class CountClaimsByMonthJob < ApplicationJob
  def perform(dealership, month, year)
    Dealerships::CreateMonthlyCount.new(dealership, month, year, :claims).call
  end
end
