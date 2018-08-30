task :create_monthly_counts do
  date = Date.today
  if date == Date.today.beginning_of_month
    Dealership.all.each do |dealership|
      CountClaimsByMonthJob.perform_now(dealership, date.month, date.year)
      CountContractsByMonthJob.perform_now(dealership, date.month, date.year)
    end
  end
  if date == Date.today.beginning_of_week
    Dealership.all.each do |dealership|
      Dealerships::CreateRecordFordAmountInReserve.new(dealership, date)
    end
  end
end
