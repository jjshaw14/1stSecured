json.id contract.id
json.dealership_id contract.dealership_id
json.dealership do
  json.id contract.dealership.id
  json.name contract.dealership.name
end
json.matured contract.matured
json.maturity_without_claims contract.maturity_without_claims.to_f.round(2)
json.lien_holder contract.lien_holder
json.lpr contract.lpr
json.length_in_months contract.length_in_months
json.length_in_months_or_years contract.length_in_months_or_years
json.contract_number contract.contract_number
json.first_name contract.first_name
json.last_name contract.last_name
json.price contract.price
json.cost contract.cost
json.email contract.email
json.mobile_number contract.mobile_number
json.home_number contract.home_number
json.work_number contract.work_number
json.up_to contract.up_to
json.stock_number contract.stock_number
json.vin contract.vin
json.make contract.make
json.model contract.model
json.year contract.year
json.odometer contract.odometer
json.purchased_on contract.purchased_on
json.miles_matured_on contract.miles_matured_on
json.address1 contract.address1
json.address2 contract.address2
json.address3 contract.address3
json.city contract.city
json.state contract.state
json.zip contract.zip
json.paid contract.paid

json.signed_copy "/api/v1/contracts/#{contract.id}/attachment.pdf" if contract.signed_copy.file.present?
json.coverage_id contract.coverage_id
unless contract.coverage.nil?
  json.package do
    json.id contract.coverage.package.id
    json.name contract.coverage.package.name
    json.coverage contract.coverage, partial: 'api/v1/coverages/coverage', as: :coverage, locals: { top_level: true }
  end if contract.coverage.package
end

json.addons contract.addons, partial: 'api/v1/addons/addon', as: :addon
json.template_id contract.template_id
json.template contract.template, partial: 'api/v1/templates/template', as: :template

json.matures_on contract.matures_on

json.history History.where(contract: contract).order(created_at: :desc) do |version|
  json.type "#{version.item_type}.#{version.event}".underscore
  begin
    json.partial! "api/v1/history/#{version.item_type}_#{version.event}".underscore
  rescue ActionView::MissingTemplate # rubocop:disable Lint/HandleExceptions
  end
  json.request_id version.request_id
  json.created_by do
    json.id version.created_by.id
    json.first_name version.created_by.first_name
    json.last_name version.created_by.last_name
  end unless version.created_by.nil?
  json.created_at version.created_at
end
json.claims_cost contract.claims_cost
json.created_at contract.created_at
json.updated_at contract.updated_at
