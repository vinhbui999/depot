class AddCartToOrders < ActiveRecord::Migration[6.1]
  def change
    add_reference :orders, :cart, index: { unique: true }
  end
end
