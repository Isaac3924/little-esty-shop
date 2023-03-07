class InvoiceItem < ApplicationRecord
  belongs_to :item
  belongs_to :invoice
  has_many :bulk_discounts, through: :item
  
  enum status: ["pending", "packaged", "shipped"]

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
