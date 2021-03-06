module ApplicationHelper
  def markdown
    @markdown ||= Redcarpet::Markdown.new(Redcarpet::Render::HTML, tables: true)
  end

  def term_in_months_or_years(term)
    distance_of_time_in_words(term).gsub(/(almost|about)\s+/, '')
  end

  def cents_to_dollars(cents)
    format('%.2f', (cents / 100.0))
  end
end
