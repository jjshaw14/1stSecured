class Dealerships::CreateMonthlyCount
  def initialize(dealership, month, year, data_type)
    @dealership = dealership
    @month = month
    @year = year
    @data_type = data_type
    @mc = DealershipTimelapsedDataPoint.find_or_initialize_by(
      dealership: dealership,
      data_type: data_type,
      month: month,
      year: year)
  end
  def call
    set_values
    save
  end
  private
  def set_values
    @mc.value = @dealership
      .send(@data_type)
      .where('extract(month from purchased_on) = ? and extract(year from purchased_on) = ?', @month, @year).count
    @mc.run_at = Date.today
  end
  def save
    @mc.save
  end
end
