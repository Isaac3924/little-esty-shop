class Merchants::DashboardController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @ready_merchant_items = @merchant.items_not_yet_shipped
    @top_customers = @merchant.merchant_top_5_customers
  end
end