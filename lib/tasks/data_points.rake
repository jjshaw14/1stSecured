
namespace :data_points do
  task backload: [:environment, :backload_claim_counts, :backload_contract_counts, :backload_amount_in_reserve]

  task backload_claim_counts: :environment do
    Dealership.all.each do |dealership|
      first_contract = dealership.contracts.order(:purchased_on).first
      if first_contract.present?
        (first_contract.purchased_on...Date.today)
          .map{|d| [d.month, d.year] }
          .uniq
          .each{|month, year|
            CountClaimsByMonthJob.perform_now(dealership, month, year)
          }
      end
    end
  end

  task backload_contract_counts: :environment do
    Dealership.all.each do |dealership|
      first_contract = dealership.contracts.order(:purchased_on).first
      if first_contract.present?
        (first_contract.purchased_on...Date.today)
          .map{|d| [d.month, d.year] }
          .uniq
          .each{|month, year|
            CountContractsByMonthJob.perform_now(dealership, month, year)
          }
      end
    end
  end

  task backload_amount_in_reserve: :environment do
    Dealership.all.each do |dealership|
      first_contract = dealership.contracts.order(:purchased_on).first
      if first_contract.present?
        mondays = (first_contract.purchased_on..Date.today).group_by(&:wday)[1]
        mondays.each do |monday|
          Dealerships::CreateRecordForAmountInReserve.new(dealership, monday).call
        end
      end
    end
  end
end
