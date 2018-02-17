json.id addon.id
json.name addon.name
json.amount addon.amount_in_cents / 100.0 unless addon.amount_in_cents.nil?
json.created_at addon.created_at
json.updated_at addon.updated_at
