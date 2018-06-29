json.array! @claims do |claim|
  json.id claim.id
  json.contract do
    json.id claim.contract.id
    json.first_name claim.contract.first_name
    json.last_name claim.contract.last_name
    json.vin claim.contract.vin
    json.model claim.contract.model
    json.year claim.contract.year
    json.purchased_on claim.contract.purchased_on
  end if claim.contract.present?
  json.cost claim.cost
  json.odometer claim.odometer
  json.shop_name claim.shop_name
  json.shop_phone claim.shop_phone
  json.shop_address claim.shop_address
  json.shop_rep claim.shop_rep
  json.shop_notes claim.shop_notes
  json.authorized_at claim.authorized_at
  json.repaired_at claim.repaired_at
  json.notes claim.notes
  json.can_it_be_safely_moved claim.can_it_be_safely_moved
  json.issue claim.issue
  json.location claim.location
  json.created_at claim.created_at
  json.updated_at claim.updated_at
end
