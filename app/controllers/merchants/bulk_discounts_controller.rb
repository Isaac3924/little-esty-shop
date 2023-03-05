class Merchants::BulkDiscountsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discounts = @merchant.bulk_discounts
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discount = @merchant.bulk_discounts.find(params[:id])
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    @new_bulk_discount = BulkDiscount.create_new_bulk_discount(bulk_discount_params)
    if @new_bulk_discount.save
      redirect_to merchant_bulk_discounts_path(bulk_discount_params[:merchant_id])
      flash[:success] = "Bulk Discount Successfully Created"
    else
      redirect_to new_merchant_bulk_discount_path(bulk_discount_params[:merchant_id])
      flash[:notice] = error_message(@new_bulk_discount.errors)
    end
  end

  private
  def bulk_discount_params
    params.permit(
      :percentage_discount,
      :quantity_threshold,
      :merchant_id
    )
  end
end