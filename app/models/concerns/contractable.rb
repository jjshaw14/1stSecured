module Contractable
  extend ActiveSupport::Concern
  def coverage_statement
    "#{length_in_months_or_years} or#{up_to ? content_tag(:span, " up to", class: 'underlined') : '' } #{number_with_delimiter limit_in_miles} miles (whichever comes first). #{caveat}"
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
