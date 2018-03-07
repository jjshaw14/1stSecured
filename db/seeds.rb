User.create!(first_name: 'Kevin', last_name: 'Primm', email: 'kfprimm@gmail.com', password: 'Password123')

PaperTrail.whodunnit = User.first.id

def new_request
  PaperTrail.controller_info = { request_id: SecureRandom.uuid, request_ip: '127.0.0.1' }
end

new_request
Fee.create!(length_in_months: 3, cost_in_cents: 2500)

new_request
Fee.create!(length_in_months: 6, cost_in_cents: 5000)

(1..3).each do |i|
  new_request
  Fee.create!(length_in_months: i * 12, cost_in_cents: 12_500)
end

(4..5).each do |i|
  new_request
  Fee.create!(length_in_months: i * 12, cost_in_cents: 15_000)
end

new_request
Fee.create!(length_in_months: 6 * 12, cost_in_cents: 15_000)

new_request
User.create!(first_name: 'Micah', last_name: 'Robinson', email: 'micah@fsadealer.com', password: 'Password123')

new_request
User.create!(first_name: 'Trevor', last_name: 'Roberts', email: 'trevor@fsadealer.com', password: 'Password123')

new_request
User.create!(first_name: 'JJ', last_name: 'Shaw', email: 'jj@makingnoyze.com', password: 'Password123')

new_request
Dealership.create!(name: 'Investment Auto 1', address1: '82 North Main Street', city: 'Centerville', state: 'UT', zip: '84014', phone: '801-797-9157')

new_request
Dealership.create!(name: 'Investment Auto 2', address1: '1100 South Main Street', city: 'Brigham City', state: 'UT', zip: '84302', phone: '435-695-CARS')

new_request
Dealership.create!(name: 'John Doe Subaru', address1: '123 Broad St.', city: 'Richmond', state: 'VA', zip: '23220', phone: '8045558855')

new_request
ServiceProvider.create!(name: '456 Body Shop', address1: '123 Broad St.', city: 'Richmond', state: 'VA', zip: '23220')

new_request
ServiceProvider.create!(name: 'XYZ Auto Glass', address1: '123 Broad St.', city: 'Richmond', state: 'VA', zip: '23220')

# rubocop:disable Layout/EmptyLinesAroundArguments
new_request
Template.create!(
  dealership: Dealership.last,
  name: 'Standard',
  packages: [
    Package.new(
      name: 'Silver', absolute_mileage: false,
      coverages: [
        Coverage.new(length_in_months: 3, limit_in_miles: 3000, cost_in_cents: 50_000),
        Coverage.new(length_in_months: 6, limit_in_miles: 6000, cost_in_cents: 50_000)
      ],
      terms: %(
From the Vehicle Purchase Date and Mileage stated above. This Limited Powertrain Service Contract has an aggregate limit of liability of $1500.

$100 STANDARD DEDUCTIBLE. **Max Payout per Component** (see Gold Package) Not to exceed aggregate limit.
      )
    ),
    Package.new(
      name: 'Gold', absolute_mileage: false,
      coverages: [
        Coverage.new(length_in_months: 1 * 12, limit_in_miles: 12_000, cost_in_cents: 50_000),
        Coverage.new(length_in_months: 2 * 12, limit_in_miles: 24_000, cost_in_cents: 50_000),
        Coverage.new(length_in_months: 3 * 12, limit_in_miles: 36_000, cost_in_cents: 50_000),
        Coverage.new(length_in_months: 4 * 12, limit_in_miles: 48_000, cost_in_cents: 50_000),
        Coverage.new(length_in_months: 5 * 12, limit_in_miles: 100_000, cost_in_cents: 50_000)
      ],
      addons: [
        Addon.new(name: 'Diesel Package'),
        Addon.new(name: 'Roadside Assistance', amount_in_cents: 10_000),
        Addon.new(name: 'Modified Suspension', amount_in_cents: 10_000)
      ],
      terms: %(
|   | MAXIMUM PAYOUT per COMPONENT |   |
| = | ============================ | = |
| Engine = $3,500.00 | Transfer Case = $1,500.00 | Starter = $500.00 |
| Transmission = $2,500.00 | Drive Axles = $1,200.00 | Alternator = $600.00 |
| Air Condition = $900.00 | Water Pump = $700.00 | Fuel Pump = $700.00 |
| Diesel Engine = $5,000.00 | Factory Turbo = $1,500.00 | Fuel Injectors = $2,000.00 |

The total aggregate limit is $10,000.00 or the Wholesale Value of the vehicle which is determined by the average current NADA Guide Wholesale (Trade-In) Value, whichever is the lesser.

STANDARD $100 DEDUCTIBLE PER CLAIM.
      )
    ),
    Package.new(
      name: 'Platinum', absolute_mileage: true,
      coverages: [
        Coverage.new(length_in_months: 4 * 12, limit_in_miles: 48_000, cost_in_cents: 50_000, caveat: 'Only for vehicles with under 100,000 miles.'),
        Coverage.new(length_in_months: 5 * 12, limit_in_miles: 100_000, cost_in_cents: 50_000, caveat: 'Only for vehicles that are current model year plus 5 years and with less than 60,000 miles at the time of purchase.'),
        Coverage.new(length_in_months: 5 * 12, limit_in_miles: 125_000, cost_in_cents: 50_000, caveat: 'Only for vehicles that are current model year plus 5 years and with less than 60,000 miles at the time of purchase,')
      ],
      addons: [
        Addon.new(name: 'Roadside Assistance', amount_in_cents: 10_000),
        Addon.new(name: 'Modified Suspension', amount_in_cents: 10_000)
      ],
      terms: %(
This service contract covers any components that were covered by the original manufacture service contract except:

1: Regular Maintenance items (tires, batteries, etc.)
2: Appearance items such as but not limited to (Paint, stitching, color fading inside or out, bright metal, and all body parts)
3: Any and all tune up items
No aggregate limit or the wholesale value of the vehicle which is determined by the average current NADA Guide (retail) Value, whichever is the lesser.

STANDARD $100 DEDUCTIBLE PER CLAIM.
      )
    )
  ]
)
# rubocop:enable Layout/EmptyLinesAroundArguments

new_request

package  = Template.first.packages.second
coverage = package.coverages.first

Contract.create!(
  dealership: Template.first.dealership, template: Template.first,
  created_by: User.first,
  first_name: 'Kevin', last_name: 'Primm', purchased_on: Date.today - 7.days,
  email: 'kfprimm@gmail.com', mobile_number: '8045138434',
  stock_number: 'ABC123', vin: 'JF1ZCAB12G9603179',
  odometer: 60_000,
  address1: '12621 Wilfong Dr', city: 'Midlothian', state: 'VA', zip: '23112-3972',
  coverage: coverage,
  addons: package.addons.sample(2)
)

new_request

attrs = JSON.parse(File.read(Rails.root.join('spec', 'example1.json'))).deep_symbolize_keys

template = Template.new(
  dealership: Dealership.first,
  name: attrs[:name]
)

attrs[:packages].each do |package_attrs|
  package = template.packages.build name: package_attrs[:name], absolute_mileage: package_attrs[:absolute_mileage]

  package_attrs[:coverages].each do |coverage_attrs|
    package.coverages.build coverage_attrs
  end
end

template.save!

CSV.foreach(
  Rails.root.join('spec', 'example1.csv'),
  headers: true,
  header_converters: ->(h) { h.parameterize.underscore.to_sym }
) do |row|
  new_request

  row[:cost] = row[:cost].to_s.gsub(/[$,]/, '').to_f * 100
  row[:price] = row[:price].to_s.gsub(/[$,]/, '').to_f * 100

  month, day, year = row[:date].split('/').map(&:to_i)

  contract = Contract.new(
    dealership: template.dealership, template: template,
    created_by: User.first,
    first_name: row[:first_name], last_name: row[:last_name], email: row[:email], home_number: row[:phone],
    stock_number: row[:stock],
    vin: row[:vin], odometer: row[:odometer], purchased_on: Date.new(year, month, day),
    address1: row[:address], city: row[:city], state: row[:state], zip: row[:zip],
    price_in_cents: row[:price]
  )

  package = template.packages.find_by!(name: row[:package])
  contract.coverage = package.coverages.find_by!(length_in_months: row[:term].to_i * 12, cost_in_cents: row[:cost])

  if contract.coverage.cost_in_cents != row[:cost]
    puts contract.coverage.inspect
    puts "#{contract.coverage.cost_in_cents} != #{row[:cost]}"
    puts row
    throw 'coverage costs does match data'
  end

  contract.save!

  if row[:claims].present?
    new_request

    contract.claims.create! odometer: contract.odometer + 1000 + Random.new.rand(10_000), cost_in_cents: row[:claims].to_s.gsub(/[$,]/, '').to_f * 100
  end
end
