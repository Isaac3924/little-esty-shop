class InvoiceItem < ApplicationRecord
  belongs_to :item
  belongs_to :invoice
  
  enum status: ["pending", "packaged", "shipped"]

  def discount_check
    item.merchant.bulk_discounts.where("quantity_threshold <= ?", quantity).order('percentage_discount DESC').limit(1)
  end
end
