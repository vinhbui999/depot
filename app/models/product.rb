class Product < ApplicationRecord
    has_many :line_items
    before_destroy :ensure_not_referenced_by_any_line_time

    validates :title, :image_url, :description, presence: true
    validates :price, numericality: { greater_than_or_equal_to: 0.01 }
    validates :title, uniqueness: true
    validates :image_url, allow_blank: true, format:{
        with: %r/\.(gif|jpg|png)\Z/i,
        message: "Must be a url for gif, jpg or png image."
    }

    private
    def ensure_not_referenced_by_any_line_item
        unless line_items.empty?
            errors.add(:base, "Line Item present")
            throw abort #if throw, the row isn't destroy
        end
    end
end
