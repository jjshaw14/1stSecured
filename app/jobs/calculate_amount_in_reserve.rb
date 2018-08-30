class CalculateAmountInReserve < ApplicationJob
  def perform(dealership, week, month, year)
    Dealership.all.each do |dealership|

    end
  end
end
