class Customer < ApplicationRecord
  has_many :orders, dependent: :destroy
  has_many :products, through: :orders

  validates :first_name, :last_name, presence: true
  validates :phone_number, presence: true, numericality: true, length: { is: 10 }
  validates :email, presence: true, uniqueness: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
end
