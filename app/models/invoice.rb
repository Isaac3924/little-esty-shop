class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :invoice_items
  has_many :transactions
  has_many :items, through: :invoice_items
  has_many :merchants, through: :invoice_items
  has_many :bulk_discounts, through: :invoice_items
  
  enum status: ["in progress", "cancelled", "completed"]

  def find_invoiceitem_quantity(item)
    self.invoice_items.find_by(item_id: item.id).quantity
  end

  def find_invoiceitem_unitprice(item)
    self.invoice_items.find_by(item_id: item.id).unit_price
  end

  def find_invoiceitem_status(item)
    self.invoice_items.find_by(item_id: item.id).status
  end

  def get_total_revenue
    invoice_items.revenue
  end

  def get_total_revenue_from_merchant(merchant)
    invoice_items.where(item_id: merchant.items.ids)
                 .revenue
  end

  def get_total_discounted_amount
    
    var = invoice_items.joins(:bulk_discounts)
                        .where('bulk_discounts.quantity_threshold <= invoice_items.quantity')
                        .select("invoice_items.*, MAX((invoice_items.unit_price*invoice_items.quantity) * (bulk_discounts.percentage_discount/100.0)) AS discounted_amount")
                        .group(:id)

                        
                        total_discount_amount = InvoiceItem.from(var, :var).select("SUM(var.discounted_amount) AS total_discount_amount").take.total_discount_amount
  end

  def get_total_discounted_amount_from_merchant(merchant)
    
    var = invoice_items.joins(:bulk_discounts)
                        .where('bulk_discounts.quantity_threshold <= invoice_items.quantity')
                        .where('bulk_discounts.merchant_id = ?', merchant.id)
                        .select("invoice_items.*, MAX((invoice_items.unit_price*invoice_items.quantity) * (bulk_discounts.percentage_discount/100.0)) AS discounted_amount")
                        .group(:id)

                        
                        total_discount_amount = InvoiceItem.from(var, :var).select("SUM(var.discounted_amount) AS total_discount_amount").take.total_discount_amount
  end

  scope :invoice_items_not_shipped, -> { joins(:invoice_items).where.not(invoice_items: {status: 2})
                                                              .distinct.order(:created_at) }
end
