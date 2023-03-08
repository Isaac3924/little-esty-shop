class InvoiceItem < ApplicationRecord
  belongs_to :item
  belongs_to :invoice
  has_many :bulk_discounts, through: :item
  
  enum status: ["pending", "packaged", "shipped"]

  scope :revenue, -> { sum("unit_price * quantity") }

  scope :check_quantity, -> { joins(:bulk_discounts).where('bulk_discounts.quantity_threshold <= invoice_items.quantity') }

  scope :calculate_discounted_amount, -> { select("invoice_items.*, MAX((invoice_items.unit_price*invoice_items.quantity) * (bulk_discounts.percentage_discount/100.0)) AS discounted_amount") }
  
  #Commenting this out as it is old unneeded code, but leaving it in as reference to show what my thought process was originally.
  #You can see the further logic in the invoice_item_spec file, those tests will also be commented out.
  # def discount_check
  #   item.merchant.bulk_discounts
  #                .where("quantity_threshold <= ?", quantity)
  #                .select('percentage_discount')
  #                .order('percentage_discount DESC')
  #                .limit(1)
  #                .select("bulk_discounts.*")
  #                .take  
  # end
end
