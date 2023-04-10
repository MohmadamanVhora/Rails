class Enrollment < ApplicationRecord
  belongs_to :user
  belongs_to :event
  scope :owner, -> { where(created: true) }
  scope :not_owner, -> { where(created: false) }
end
