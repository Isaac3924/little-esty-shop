class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices, through: :items
  has_many :invoice_items, through: :items
  has_many :customers, through: :invoices 
  has_many :transactions, through: :invoices

  def merchant_invoices
    invoices.distinct.order(:id)
  end

  def items_not_yet_shipped
    invoices.order(created_at: :asc)
    invoice_items.where.not(status: "shipped")
  end

  def merchant_top_5_customers
    # customers.distinct
    # .joins(:transactions)
    # .where(transactions: { result: 0 })
    # .group(:id)
    # .select("customers.*, COUNT(transactions.id) as transaction_count")
    # .order(transaction_count: :desc)
    # .limit(5)
  end
end
