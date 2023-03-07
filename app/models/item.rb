class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  has_many :bulk_discounts, through: :merchant
  
  validates_presence_of :name
  validates_presence_of :description
  validates_presence_of :unit_price
  enum status: {enabled: 0, disabled: 1}

  def self.create_new_item(item_params)
    create(item_params)
  end

  def find_invoice_item(invoice)
    invoice_items.where(item_id: id, invoice_id: invoice.id).take
  end

  def find_best_bulk_discount(invoice)
    merchant.bulk_discounts
            .where("quantity_threshold <= ?", find_invoice_item(invoice)
            .quantity)
            .select('percentage_discount')
            .order('percentage_discount DESC')
            .limit(1)
            .select("bulk_discounts.*")
            .take  
  end

  def best_day
    self.invoices.joins(:transactions)
    .select("invoices.created_at AS inv_date, SUM(invoice_items.quantity) AS most_sales")
    .where(transactions: {result: 0})
    .order(most_sales: :desc, inv_date: :desc)
    .group("invoices.created_at").first.inv_date
  end
end
