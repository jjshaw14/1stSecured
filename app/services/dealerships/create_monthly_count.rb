class Dealerships::CreateMonthlyCount
  def initialize(dealership, month, year, data_type)
    @dealership = dealership
    @month = month
    @year = year
    @data_type = data_type
    @column = @data_type == :claims ? 'authorized_at' : 'purchased_on'
    @mc = TimelapsedDataPoint.find_or_initialize_by(
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
      .without_deleted
      .where("extract(month from #{@column}) = ? and extract(year from #{@column}) = ?", @month, @year).count

    @mc.run_at = Date.today
  end
  def save
    @mc.save
  end
end
