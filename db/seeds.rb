User.create!(first_name: 'Kevin', last_name: 'Primm', email: 'kfprimm@gmail.com', password: 'Password123')

Dealership.create!(name: 'ABC Jeep', address1: '123 Broad St.', city: 'Richmond', state: 'VA', zip: '23220', phone: '8045558855')
Dealership.create!(name: 'Smith Honda', address1: '123 Broad St.', city: 'Richmond', state: 'VA', zip: '23220', phone: '8045558855')
Dealership.create!(name: 'Doe Subaru', address1: '123 Broad St.', city: 'Richmond', state: 'VA', zip: '23220', phone: '8045558855')

Template.create!(
  dealership: Dealership.first,
  name: 'Standard',
  packages: [
    Package.new(
      name: 'Silver',
      coverages: [
        Coverage.new(length_in_months: 3, limit_in_miles: 3000),
        Coverage.new(length_in_months: 6, limit_in_miles: 6000)
      ],
      terms: %(
        From the Vehicle Purchase Date and Mileage stated above. This Limited Powertrain Service Contract has an aggregate limit of liability of $1500.
        $100 STANDARD DEDUCTIBLE. **Max Payout per Component** (see Gold Package) Not to exceed aggregate limit.
      )
    ),
    Package.new(
      name: 'Gold',
      coverages: [
        Coverage.new(length_in_months: 1*12, limit_in_miles: 12000),
        Coverage.new(length_in_months: 2*12, limit_in_miles: 24000),
        Coverage.new(length_in_months: 3*12, limit_in_miles: 36000),
        Coverage.new(length_in_months: 4*12, limit_in_miles: 48000),
        Coverage.new(length_in_months: 5*12, limit_in_miles: 100000)
      ],
      addons: [
        Addon.new(name: 'Diesel Package'),
        Addon.new(name: 'Roadside Assistance', amount_in_cents: 10000),
        Addon.new(name: 'Modified Suspension', amount_in_cents: 10000)
      ],
      terms: %(
        MAXIMUM PAYOUT per COMPONENT
        Engine = $3,500.00 Transfer Case = $1,500.00 Starter = $500.00
        Transmission = $2,500.00 Drive Axles = $1,200.00 Alternator = $600.00
        Air Condition = $900.00 Water Pump = $700.00 Fuel Pump = $700.00
        Diesel Engine = $5,000.00 Factory Turbo = $1,500.00 Fuel Injectors = $2,000.00
        The total aggregate limit is $10,000.00 or the Wholesale Value of the vehicle which is determined by the average current NADA Guide Wholesale
        (Trade-In) Value, whichever is the lesser. STANDARD $100 DEDUCTIBLE PER CLAIM.
      )
    ),
    Package.new(
      name: 'Platinum',
      coverages: [
        Coverage.new(length_in_months: 4*12, limit_in_miles: 48000, caveat: 'Only for vehicles with under 100,000 miles.'),
        Coverage.new(length_in_months: 5*12, limit_in_miles: 100000, caveat: 'Only for vehicles that are
current model year plus 5 years and with less than 60,000 miles at the time of purchase.'),
        Coverage.new(length_in_months: 5*12, limit_in_miles: 125000, caveat: 'Only for vehicles that are
current model year plus 5 years and with less than 60,000 miles at the time of purchase,'),
      ],
      addons: [
        Addon.new(name: 'Roadside Assistance', amount_in_cents: 10000),
        Addon.new(name: 'Modified Suspension', amount_in_cents: 10000)
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

package  = Template.first.packages.second
coverage = package.coverages.first

Contract.create!(dealership: Dealership.first, template: Template.first, created_by: User.first, first_name: 'Kevin', last_name: 'Primm', purchased_on: Date.today - 7.days, vin: 'JF1ZCAB12G9603179', odometer: 60000, address1: '12621 Wilfong Dr', city: 'Midlothian', state: 'VA', zip: '23112-3972', coverage: coverage, addons: package.addons.sample(2))
