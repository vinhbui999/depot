class AddShipDateToOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :ship_date, :time, default: Time.now.to_s(:db)
  end
end
