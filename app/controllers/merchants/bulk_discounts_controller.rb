class Merchants::BulkDiscountsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discounts = @merchant.bulk_discounts
    WebMock.allow_net_connect!
    @holiday_info = @holidays = HolidaySearch.new.holiday_information
    WebMock.disable_net_connect!
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

  def destroy
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discount = @merchant.bulk_discounts.find(params[:id])
    @bulk_discount.destroy
    redirect_to merchant_bulk_discounts_path(bulk_discount_params[:merchant_id])
  end

  def edit
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discount = @merchant.bulk_discounts.find(params[:id])
  end

  def update
    merchant = Merchant.find(params[:merchant_id])
    bulk_discount = merchant.bulk_discounts.find(params[:id])

    if bulk_discount_params[:status].present?
      bulk_discount.update!(bulk_discount_params)
      redirect_to merchant_bulk_discounts_path(merchant)
    else
      if bulk_discount.update(bulk_discount_params)
        flash[:success] = "bulk_discount Successfully Updated"
        redirect_to merchant_bulk_discount_path(merchant, bulk_discount)
      else
        flash[:notice] = error_message(bulk_discount.errors)
        redirect_to edit_merchant_bulk_discount_path(merchant, bulk_discount)
      end
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