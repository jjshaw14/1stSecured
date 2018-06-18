json.costs dealership.contracts.without_deleted.sum(:cost_in_cents)
json.costs_this_month dealership.contracts.without_deleted.this_month.sum(:cost_in_cents)
json.claims dealership.contracts.without_deleted.joins(:claims).sum('claims.cost_in_cents')
json.claims_this_month Claim.by_dealership(dealership).this_month.sum('claims.cost_in_cents')
json.fees_this_month dealership.contracts.without_deleted.this_month.sum(:fee_in_cents)
json.fees dealership.contracts.without_deleted.sum(:fee_in_cents)
json.loss_ratio dealership.contracts.without_deleted.loss_ratio
