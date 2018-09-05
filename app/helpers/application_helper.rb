module ApplicationHelper
  def markdown
    @markdown ||= Redcarpet::Markdown.new(Redcarpet::Render::HTML, tables: true)
  end

  def term_in_months_or_years(term)
    term > 18 ? "#{term / 12} years" : "#{term} months"
  end

  def cents_to_dollars(cents)
    format('%.2f', (cents / 100.0))
  end
end
