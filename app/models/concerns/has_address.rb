module HasAddress
  extend ActiveSupport::Concern

  def address_lines
    [address1, address2, address3].select(&:present?).join(', ')
  end

  def address
    [address_lines, city, [state, zip].join(' ')].join(', ')
  end
end
