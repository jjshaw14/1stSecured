class VinLookupService
  def execute(vin)
    Rails.cache.fetch("vin/#{vin}") do
      response = HTTParty.get("https://vpic.nhtsa.dot.gov/api/vehicles/decodevin/#{vin}?format=json")
      data = JSON.parse(response.body)

      { 'Make' => :make, 'Model' => :model, 'Model Year' => :year }.each_with_object({}) do |(original_key, new_key), res|
        res[new_key] = data['Results'].find { |r| r['Variable'] == original_key }['Value']
        res
      end
    end
  end
end
