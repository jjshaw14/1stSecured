json.id addon.id
json.name addon.name

json.cost addon.cost_in_cents / 100.0 unless addon.cost_in_cents.nil?
json.price addon.price_in_cents / 100.0 unless addon.price_in_cents.nil?

json.created_at addon.created_at
json.updated_at addon.updated_at
