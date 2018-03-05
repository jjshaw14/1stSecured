json.id contract.id

json.dealership do
  json.id contract.dealership.id
  json.name contract.dealership.name
end

json.first_name contract.first_name
json.last_name contract.last_name

json.email contract.email
json.mobile_number contract.mobile_number
json.home_number contract.home_number
json.work_number contract.work_number

json.vin contract.vin
json.make contract.make
json.model contract.model
json.year contract.year
json.odometer contract.odometer
json.purchased_on contract.purchased_on

json.address1 contract.address1
json.address2 contract.address2
json.address3 contract.address3
json.city contract.city
json.state contract.state
json.zip contract.zip

json.coverage contract.coverage, partial: 'api/v1/coverages/coverage', as: :coverage unless contract.coverage.nil?

json.addons contract.addons, partial: 'api/v1/addons/addon', as: :addon

json.template contract.template, partial: 'api/v1/templates/template', as: :template

json.matures_on contract.matures_on

json.history History.where(contract: contract).order(created_at: :desc) do |version|
  json.type "#{version.item_type}.#{version.event}".underscore
  begin
    json.partial! "api/v1/history/#{version.item_type}_#{version.event}".underscore
  rescue ActionView::MissingTemplate
  end
  json.request_id version.request_id
  json.created_by do
    json.id version.created_by.id
    json.first_name version.created_by.first_name
    json.last_name version.created_by.last_name 
  end
  json.created_at version.created_at
end

json.created_at contract.created_at
json.updated_at contract.updated_at
