# frozen_string_literal: true

module LineItemsHelper
  def exchange(price, locale)
    case locale.to_s
    when 'vn'
      (price * 23_048.39).ceil(2)
    else price
    end
  end
end
