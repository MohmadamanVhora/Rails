class User < ApplicationRecord
  has_many :enrollments
  has_many :events, through: :enrollments
  has_one :profile
end
