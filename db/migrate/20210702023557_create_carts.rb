class CreateCarts < ActiveRecord::Migration[6.1]
  def change
    create_table :carts, &:timestamps
  end
end
