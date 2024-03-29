# frozen_string_literal: true

class LineItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product, optional: true
  belongs_to :order, optional: true

  def total_price
    product.price * quantity
  end
end
