class Dealerships::CreateRecordForAmountInReserve
  def initialize(dealership, date)
    @dealership = dealership
    @date = date
    @data_point = TimelapsedDataPoint.find_or_initialize_by(
      dealership: @dealership,
      run_at: @date
    )
  end
  def call
    calculate_amount_in_reserve
    save
  end
  def calculate_amount_in_reserve
    claims = @dealership.claims.without_deleted.where('authorized_at < ?', @date).sum(:cost_in_cents)
    fees = @dealership.contracts.without_deleted.where('purchased_on < ?', @date).sum(:fee_in_cents)
    cost = @dealership.contracts.without_deleted.where('purchased_on < ?', @date).sum(:cost_in_cents)
    @data_point.data_type = :reserves
    @data_point.value = cost - fees - claims
  end
  def save
    @data_point.save
  end
end
