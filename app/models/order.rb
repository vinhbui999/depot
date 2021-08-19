class Order < ApplicationRecord
    enum pay_type: {
        "Check" => 0,
        "Credit Card" => 1,
        "Purchase Order" => 2
    }
    validates :name, :address, :email, presence: true
    validates :pay_type, inclusion: pay_types.keys
    has_many :line_items, dependent: :destroy
    belongs_to :user, optional: true
    has_one :cart, dependent: :destroy
    

    def add_line_items_from_cart(cart) 
        cart.line_items.each do |item|
            # item.cart_id = nil
            line_items << item
        end 
    end
end
