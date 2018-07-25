module Contractable
  extend ActiveSupport::Concern

  include ActionView::Helpers::NumberHelper
  def coverage_statement
    "#{length_in_months_or_years} or#{up_to ? content_tag(:span, " up to", class: 'underlined') : '' } #{number_with_delimiter limit_in_miles} miles (whichever comes first). #{caveat}"
  end

  def maturity
    purchased_on.present? ? Date.today - purchased_on : 0
  end
  def term
    ( ( length_in_months || 0 )  / 12 ) * 365
  end
  def lpr
    number_to_percentage(( ( term / (maturity === 0 ? 1 : maturity) ) * claims.without_deleted.sum(:cost_in_cents) ) / ( cost_in_cents || 1 ) * 100)
  end

  def matured
    ((maturity_without_claims - claims.without_deleted.sum(:cost_in_cents) / 100)).to_f.round(2)
  end
  def maturity_without_claims
    (maturity_over_term * ( cost_in_cents || 0  ) / 100)
  end
  def term_over_maturity
   ratio = term / (maturity === 0 ? 1 : maturity)
   ratio <= 1 ? 1 : ratio
  end
  def maturity_over_term
    ratio= maturity / (term == 0 ? 1 : term)
    ratio >= 1 ? 1 : ratio
  end
  def length_in_months_or_years
    if length_in_months
      length_in_months < 12 ?
        length_in_months.to_s + ' months' :
        (length_in_months / 12).to_s  + ' years'
    end
  end
  def number_with_delimiter number
    ActiveSupport::NumberHelper::number_to_delimited number
  end
end
