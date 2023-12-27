# frozen_string_literal: true

module StoreHelper
  def exchange(price, locale)
    case locale.to_s
    when 'vn'
      (price * 23_048.39).ceil(2)
    else price
    end
  end

  def page_title
    @page_title || 'Pragmatic Store'
  end
end
