json.costs dealership.contracts.without_deleted.sum(:cost_in_cents)
json.costs_this_month dealership.contracts.without_deleted.this_month.sum(:cost_in_cents)
json.claims Claim.by_dealership(dealership).without_deleted.sum('claims.cost_in_cents')
json.claims_this_month Claim.by_dealership(dealership).without_deleted.this_month.sum('claims.cost_in_cents')
json.fees_this_month dealership.contracts.without_deleted.this_month.where(paid: false).sum(:fee_in_cents)
json.fees dealership.contracts.without_deleted.sum(:fee_in_cents)
json.loss_ratio dealership.contracts.performance.loss_ratio
json.matured dealership.contracts.performance.matured_with_claims
json.matured_without_claims dealership.contracts.performance.matured_without_claims
