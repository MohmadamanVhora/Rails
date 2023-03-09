class Product < ApplicationRecord
  validates :name, presence: true, length: {maximum: 15}
  validates :category, presence: true, length: {maximum: 30}
  validates :price, numericality: true, presence: true
  validates :description, presence: true, length: {minimum:10}  

  before_save do
    self.name = name.capitalize
  end
end
