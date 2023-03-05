require 'rails_helper'

RSpec.describe BulkDiscount, type: :model do
  it { should belong_to :merchant }

  describe "Instance methods" do
  
  end
  
  describe "Class methods" do
    let!(:merchant_1) { Merchant.create!(name: "Mr. Chant") }

    it '#create_new_bulk_discount' do
      bulk_discount_params = {
        percentage_discount: 24,
        quantity_threshold: 711,
        merchant_id: merchant_1.id
      }

      expect(BulkDiscount.create_new_bulk_discount(bulk_discount_params)).to eq(merchant_1.bulk_discounts.last)
    end
  end
end
  