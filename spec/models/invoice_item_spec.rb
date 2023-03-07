require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  # let!(:merchant_1) { Merchant.create!(name: "Mr. Chant") }
  # let!(:merchant_2) { Merchant.create!(name: "Mr. Chans") }
  # let!(:merchant_3) { Merchant.create!(name: "Mr. Chany") }
  # let!(:merchant_4) { Merchant.create!(name: "Mr. ChanX") }
  # let!(:merchant_5) { Merchant.create!(name: "Mr. Chance") }
  # let!(:merchant_5_1) { Merchant.create!(name: "Mr. No") }
  
  # let!(:bulk_discount_1) { merchant_1.bulk_discounts.create!(percentage_discount: 20, quantity_threshold: 10) }
  # let!(:bulk_discount_2) { merchant_2.bulk_discounts.create!(percentage_discount: 20, quantity_threshold: 10) }
  # let!(:bulk_discount_3_A) { merchant_3.bulk_discounts.create!(percentage_discount: 20, quantity_threshold: 10) }
  # let!(:bulk_discount_3_B) { merchant_3.bulk_discounts.create!(percentage_discount: 30, quantity_threshold: 15) }
  # let!(:bulk_discount_4_A) { merchant_4.bulk_discounts.create!(percentage_discount: 20, quantity_threshold: 10) }
  # let!(:bulk_discount_4_B) { merchant_4.bulk_discounts.create!(percentage_discount: 15, quantity_threshold: 15) }
  # let!(:bulk_discount_5_A) { merchant_5.bulk_discounts.create!(percentage_discount: 20, quantity_threshold: 10) }
  # let!(:bulk_discount_5_B) { merchant_5.bulk_discounts.create!(percentage_discount: 30, quantity_threshold: 15) }

  # let!(:customer_1) { Customer.create!(first_name: "A", last_name: "A") }
  # let!(:customer_2) { Customer.create!(first_name: "B", last_name: "B") }
  # let!(:customer_3) { Customer.create!(first_name: "C", last_name: "C") }
  # let!(:customer_4) { Customer.create!(first_name: "D", last_name: "D") }
  # let!(:customer_5) { Customer.create!(first_name: "D", last_name: "D") }
  
  # let!(:invoice_1) { customer_1.invoices.create!() }
  # let!(:invoice_2) { customer_2.invoices.create!() }
  # let!(:invoice_3) { customer_3.invoices.create!() }
  # let!(:invoice_4) { customer_4.invoices.create!() }
  # let!(:invoice_5) { customer_5.invoices.create!() }
  # let!(:invoice_5_1) { customer_5.invoices.create!() }
  
  # let!(:item_1_A) { Item.create!(name: "Toy", description: "For kinder", unit_price: 200, merchant_id: merchant_1.id) }
  # let!(:item_1_B) { Item.create!(name: "Stapler", description: "For paper", unit_price: 400, merchant_id: merchant_1.id) }
  # let!(:item_2_A) { Item.create!(name: "Chocolate", description: "Get me sum MALK", unit_price: 1000, merchant_id: merchant_2.id) }
  # let!(:item_2_B) { Item.create!(name: "Milk", description: "Needs chocolate", unit_price: 1000, merchant_id: merchant_2.id) }
  # let!(:item_3_A) { Item.create!(name: "Game", description: "Have fun", unit_price: 1000, merchant_id: merchant_3.id) }
  # let!(:item_3_B) { Item.create!(name: "PC", description: "Personallly compute", unit_price: 1000, merchant_id: merchant_3.id) }
  # let!(:item_4_A) { Item.create!(name: "Cheese", description: "Sometimes, I dream about cheese", unit_price: 1000, merchant_id: merchant_4.id) }
  # let!(:item_4_B) { Item.create!(name: "Book", description: "Words go.", unit_price: 1000, merchant_id: merchant_4.id) }
  # let!(:item_5_A) { Item.create!(name: "Eye Drops", description: "Consume through eyes", unit_price: 1000, merchant_id: merchant_5.id) }
  # let!(:item_5_B) { Item.create!(name: "Frisbe", description: "It frisbs", unit_price: 1000, merchant_id: merchant_5.id) }
  # let!(:item_5_C) { Item.create!(name: "Poster", description: "Post where you want", unit_price: 1000, merchant_id: merchant_5_1.id) }

  # before(:each) do
  #   @merchant = Merchant.create!(name: "Cabbage Merchant")
  #   @dis_gai_ovah_hea = Customer.create!(first_name: "Dis", last_name: "Gai")
    
  #   @item1 = @merchant.items.create!(name: "Ramen Noodles", description: "A dang good pack-a ramen", unit_price: 99)
  #   @item2 = @merchant.items.create!(name: "Cabbages", description: "NOT MY CABBAGES!!!", unit_price: 500)
  #   @item3 = @merchant.items.create!(name: "Freesh Avacadoo", description: "Cream Freesh", unit_price: 200)
    
  #   @invoice1 = Invoice.create!(customer_id: @dis_gai_ovah_hea.id, status: 0 )
  #   @invoice2 = Invoice.create!(customer_id: @dis_gai_ovah_hea.id, status: 0 )
  #   @invoice3 = Invoice.create!(customer_id: @dis_gai_ovah_hea.id, status: 2 ) 
    
  #   @inv_it_1 = InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice1.id, quantity: 100, unit_price: 100, status: 0 )
  #   @inv_it_2 = InvoiceItem.create!(item_id: @item2.id, invoice_id: @invoice2.id, quantity: 100, unit_price: 475, status: 1 )
  #   @inv_it_3 = InvoiceItem.create!(item_id: @item3.id, invoice_id: @invoice3.id, quantity: 100, unit_price: 225, status: 2 )

  #   @invoice_item_1_A = invoice_1.invoice_items.create!( item: item_1_A, quantity: 5, unit_price: 500, status: 0)
  #   @invoice_item_1_B = invoice_1.invoice_items.create!( item: item_1_B, quantity: 5, unit_price: 600, status: 0)
  #   @invoice_item_2_A = invoice_2.invoice_items.create!( item: item_2_A, quantity: 10, unit_price: 1000, status: 0)
  #   @invoice_item_2_B = invoice_2.invoice_items.create!( item: item_2_B, quantity: 5, unit_price: 1000, status: 0)
  #   @invoice_item_3_A = invoice_3.invoice_items.create!( item: item_3_A, quantity: 12, unit_price: 1000, status: 0)
  #   @invoice_item_3_B = invoice_3.invoice_items.create!( item: item_3_B, quantity: 15, unit_price: 1000, status: 0)
  #   @invoice_item_4_A = invoice_4.invoice_items.create!( item: item_4_A, quantity: 12, unit_price: 1000, status: 0)
  #   @invoice_item_4_B = invoice_4.invoice_items.create!( item: item_4_B, quantity: 15, unit_price: 1000, status: 0)
  #   @invoice_item_5_A = invoice_5.invoice_items.create!( item: item_5_A, quantity: 12, unit_price: 1000, status: 0)
  #   @invoice_item_5_B = invoice_5.invoice_items.create!( item: item_5_B, quantity: 15, unit_price: 1000, status: 0)
  #   @invoice_item_5_C = invoice_5_1.invoice_items.create!( item: item_5_C, quantity: 15, unit_price: 1000, status: 0)
  # end

  describe "Relationships" do
    it { should belong_to :invoice }
    it { should belong_to :item }
  end

  describe "Instance methods" do
    # it 'does not apply the discount to 1 tier variables' do
    #   expect(@invoice_item_1_A.discount_check).to eq(nil)
    # end

    # it 'does apply the discount to 2 tier A variables' do
    #   expect(@invoice_item_2_A.discount_check).to eq(bulk_discount_2)
    # end

    # it 'applies 20% discount to tier 3_A and 30% to 3_B' do
    #   expect(@invoice_item_3_A.discount_check).to eq(bulk_discount_3_A)
    #   expect(@invoice_item_3_B.discount_check).to eq(bulk_discount_3_B)
    # end

    # it 'applies 20% discount to all tier 3 variables not 15%' do
    #   expect(@invoice_item_4_A.discount_check).to eq(bulk_discount_4_A)
    #   expect(@invoice_item_4_B.discount_check).to eq(bulk_discount_4_A)
    #   expect(@invoice_item_4_A.discount_check).to_not eq(bulk_discount_4_B)
    #   expect(@invoice_item_4_B.discount_check).to_not eq(bulk_discount_4_B)
    # end

    # it 'applies 20% discount to 5_A, 30% discount to 5_B, and none to 5_C' do
    #   expect(@invoice_item_5_A.discount_check).to eq(bulk_discount_5_A)
    #   expect(@invoice_item_5_B.discount_check).to eq(bulk_discount_5_B)
    #   expect(@invoice_item_5_C.discount_check).to eq(nil)
    # end
  end
end
