class Author < ApplicationRecord
  has_many :books, dependent: :destroy

  validates :first_name, presence: true, length: {minimum:3, maximum:15}
  validates :last_name, presence: true, length: {minimum:3, maximum:15}
  validates_date :dob, presence: true , on_or_before: :today, after: '1900-01-01'
  validates :email, presence: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
end
