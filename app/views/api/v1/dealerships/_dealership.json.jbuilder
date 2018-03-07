json.id dealership.id
json.name dealership.name

json.address1 dealership.address1
json.address2 dealership.address2
json.address3 dealership.address3
json.city dealership.city
json.state dealership.state
json.zip dealership.zip

json.performance do
  json.costs dealership.contracts.joins(:coverage).sum('coverages.cost_in_cents')
  json.claims dealership.contracts.joins(:claims).sum('claims.cost_in_cents')
  json.fees dealership.contracts.sum('fee_in_cents')
  json.loss_ratio dealership.contracts.left_joins(:claims).left_joins(:coverage).left_joins(:addons).select("((SUM(coverages.length_in_months) / 12.0) * 365)::integer AS term_total, SUM(current_date - purchased_on) AS term_completed, SUM(claims.cost_in_cents) AS _claims, SUM(coverages.cost_in_cents) + SUM(COALESCE(addons.cost_in_cents, 0)) AS costs, ROUND(((((SUM(coverages.length_in_months) / 12.0) * 365) / SUM(current_date - purchased_on)) * SUM(claims.cost_in_cents)) / (SUM(coverages.cost_in_cents) + SUM(COALESCE(addons.cost_in_cents, 0))) * 100, 2) AS loss_ratio").to_a.first.loss_ratio
  # json.loss_ratio dealership.contracts.sum("DATE_PART('days', NOW() - purchased_on)")
end

json.templates dealership.templates, partial: 'api/v1/templates/template', as: :template
json.users dealership.users, partial: 'api/v1/users/user', as: :user

json.created_at dealership.created_at
json.updated_at dealership.updated_at
