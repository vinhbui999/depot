# frozen_string_literal: true

class Cart < ApplicationRecord
  has_many :line_items, dependent: :destroy
  belongs_to :order, optional: true

  def add_product(product)
    current_item = line_items.find_by(product_id: product.id)
    if current_item
      current_item.quantity += 1
      current_item.product_price += product.price
    else
      current_item = line_items.build(product_id: product.id) # if it not exist create a new line_item
      current_item.product_price = product.price
    end
    current_item
  end

  def total_price
    line_items.to_a.sum(&:total_price)
  end
end
