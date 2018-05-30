json.costs dealership.contracts.joins(:coverage).sum('coverages.cost_in_cents')
json.costs_this_month dealership.contracts.joins(:coverage).sum('coverages.cost_in_cents')
json.claims dealership.contracts.joins(:claims).sum('claims.cost_in_cents')
json.claims_this_month Claim.by_dealership(dealership).this_month.sum('claims.cost_in_cents')
json.fees_this_month dealership.contracts.this_month.sum('fee_in_cents')
json.fees dealership.contracts.sum('fee_in_cents')
json.loss_ratio dealership.contracts.loss_ratio
# json.loss_ratio dealership.contracts.sum("DATE_PART('days', NOW() - purchased_on)")
