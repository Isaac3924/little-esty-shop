class Merchants::InvoicesController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @invoices = @merchant.merchant_invoices
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @invoice = @merchant.invoices.find(params[:id])
    @inv_items = @invoice.invoice_items
  end

  def update
    merchant = Merchant.find(params[:merchant_id])
    invoice = merchant.invoices.find(params[:id])
    invoice_item = InvoiceItem.find_by(invoice_id: params[:id], item_id: params[:item_id])
    invoice_item.update(status: params[:status])

    redirect_to merchant_invoice_path(merchant, invoice)
  end
end