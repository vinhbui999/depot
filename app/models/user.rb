# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password
  before_save { self.email = email.downcase }
  validates :name, presence: true

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+(\.[a-z\d-]+)*\.[a-z]+\z/i.freeze

  validates :email, presence: true, uniqueness: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX },
                    on: :create

  after_destroy :ensure_an_admin_remains
  has_many :orders, dependent: :destroy

  DEFAULT_PASS = 'vinh123'
end

class Error < StandardError
end

private

def ensure_an_admin_remains
  return unless User.count.zero?

  raise Error, "Can't delete last user"
end
