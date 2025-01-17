class BulkDiscount < ApplicationRecord
  belongs_to :merchant
  
  validates :percentage_discount, presence: true, numericality: { greater_than: 0, less_than_or_equal_to: 100}
  validates :quantity_threshold, presence: true, numericality: { greater_than: 0 }
  validates_presence_of :merchant_id

  def self.create_new_bulk_discount(bulk_discount_params)
    create(bulk_discount_params)
  end
end
