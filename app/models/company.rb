class Company < ApplicationRecord
    validates :name, presence: true, uniqueness: true
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

    validates :email, uniqueness: true, length: {maximum: 255}, format:{ with: VALID_EMAIL_REGEX}, on: :create
    validates :phonenumber, numericality: true, length: {minimum: 10, maximum: 12}
    validates :address, presence: true, length: {maximum: 255}
end