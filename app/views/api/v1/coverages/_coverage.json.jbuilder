json.id coverage.id
json.length_in_months coverage.length_in_months
json.limit_in_miles coverage.limit_in_miles
json.cost coverage.cost_in_cents ? cents_to_dollars(coverage.cost_in_cents) : 0
json.caveat coverage.caveat
json.created_at coverage.created_at
json.updated_at coverage.updated_at
