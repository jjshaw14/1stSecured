json.id addon.id
json.name addon.name

json.cost addon.cost_in_cents / 100.0 unless addon.cost_in_cents.nil?
json.fee addon.fee_in_cents ? addon.fee_in_cents / 100.0 : 0
json.created_at addon.created_at
json.updated_at addon.updated_at
