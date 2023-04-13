class Order < ApplicationRecord
  belongs_to :product
  belongs_to :customer

  validates :quantity, presence: true
  validates :order_status, inclusion: { in: %w[booked canceled] }
  enum :status, { 'Booked': 'booked', 'Canceled': 'canceled' }

  before_save :count_total_price

  def product
    Product.unscoped{ super }
  end

  private
  def count_total_price
    product_price = Product.unscoped.find_by(id: product_id).price
    self.total_price = quantity * product_price
  end
end
