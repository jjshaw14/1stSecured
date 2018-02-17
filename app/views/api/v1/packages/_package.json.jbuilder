json.id package.id
json.name package.name

json.coverages package.coverages, partial: 'api/v1/coverages/coverage', as: :coverage
json.addons package.addons, partial: 'api/v1/addons/addon', as: :addon
json.terms package.terms

json.created_at package.created_at
json.updated_at package.updated_at
