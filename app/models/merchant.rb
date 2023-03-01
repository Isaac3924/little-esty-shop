class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices, through: :items
  has_many :invoice_items, through: :items
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices
  enum status: {enabled: 0, disabled: 1}

  scope :enabled_merchants, -> { where("status = 0")}

  scope :disabled_merchants, -> { where("status = 1")}
  
  validates_presence_of :name

  def self.create_new_merchant(merchant_params)
    create(merchant_params)
  end

  def merchant_invoices
    invoices.distinct.order(:id)
  end

  def items_not_yet_shipped
    invoices.order(created_at: :asc)
    invoice_items.where.not(status: "shipped")
  end
  
  def top_5_items_by_revenue
    items.joins(invoice_items: {invoice: :transactions}).where(transactions: {result: 0}).group(:id).select('items.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS total_revenue').order('total_revenue DESC').limit(5)
  end

  def merchant_top_5_customers
    self.customers.joins(:transactions).where(transactions: {result: 'success'}).group("customers.id").select("CONCAT(customers.first_name,' ', customers.last_name) AS full_name, COUNT(DISTINCT transactions.id) AS successful_order").order(successful_order: :desc, full_name: :asc).limit(5)
  end

  def enabled_items
    items.where(status: 0)
  end

  def disabled_items
    items.where(status: 1)
  end
end
