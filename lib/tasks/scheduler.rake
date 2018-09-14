task :create_monthly_counts do

  if Date.today == Date.today.beginning_of_month
    date = Date.today.beginning_of_month - 1
    Dealership.all.each do |dealership|
      CountClaimsByMonthJob.perform_now(dealership, date.month, date.year)
      CountContractsByMonthJob.perform_now(dealership, date.month, date.year)
    end
  end
  if Date.today == Date.today.beginning_of_week
    Dealership.all.each do |dealership|
      Dealerships::CreateRecordFordAmountInReserve.new(dealership, Date.today)
    end
  end
end
