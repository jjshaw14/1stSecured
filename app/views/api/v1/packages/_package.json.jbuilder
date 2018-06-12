json.id package.id
json.name package.name

json.coverages package.coverages.order(:order), partial: 'api/v1/coverages/coverage', as: :coverage
json.addons package.addons, partial: 'api/v1/addons/addon', as: :addon
json.terms package.terms

json.absolute_mileage package.absolute_mileage?

json.created_at package.created_at
json.updated_at package.updated_at
