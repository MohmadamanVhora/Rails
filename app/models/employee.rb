class Employee < ApplicationRecord
  validates :first_name, :last_name, :email, :age, :no_of_order, :full_time_available, :salary, presence: true
end
