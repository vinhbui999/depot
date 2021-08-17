class AddOrderToCarts < ActiveRecord::Migration[6.1]
  def change
    add_reference :carts, :order, index: { unique: true }
  end
end
