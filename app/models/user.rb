class User < ApplicationRecord
  has_many :enrollments
  has_many :events, through: :enrollments
  has_one :profile
  has_one :address, as: :addressable
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
end
