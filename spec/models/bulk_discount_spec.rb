require 'rails_helper'

RSpec.describe BulkDiscount, type: :model do
  it { should belong_to :merchant }

  describe "Instance methods" do
    
    let!(:merchant_a) { Merchant.create!(name: "Mr. Chant") }
  
    let!(:bulk_discount_a) { merchant_a.bulk_discounts.create!(percentage_discount: 20, quantity_threshold: 10) }

    let!(:customer_a) { Customer.create!(first_name: "A", last_name: "A") }
  
    let!(:invoice_a) { customer_a.invoices.create!() } 
  
    let!(:item_a1) { Item.create!(name: "Toy", description: "For kinder", unit_price: 200, merchant_id: merchant_a.id) }
    let!(:item_a2) { Item.create!(name: "Stapler", description: "For paper", unit_price: 400, merchant_id: merchant_a.id) }
  
  
    before do
      @invoice_item_a1 = invoice_a.invoice_items.create!( item: item_a1, quantity: 5, unit_price: 500, status: 0)
      @invoice_item_a2 = invoice_a.invoice_items.create!( item: item_a2, quantity: 5, unit_price: 600, status: 0)
    end

    it 'does not apply the discount to A tier variables' do
      expect(@invoice_item_a1.discount_check).to eq([])
    end
  
  #   it "#find_invoiceitem_quantity" do
  #     expect(invoice1.find_invoiceitem_quantity(item1)).to eq(30)
  #     expect(invoice1.find_invoiceitem_quantity(item2)).to eq(6)
  #     expect(invoice2.find_invoiceitem_quantity(item4)).to eq(500)
  #   end
  
  #   it "#find_invoiceitem_unitprice" do
  #     expect(invoice1.find_invoiceitem_unitprice(item1)).to eq(336)
  #     expect(invoice1.find_invoiceitem_unitprice(item2)).to eq(34571)
  #     expect(invoice2.find_invoiceitem_unitprice(item4)).to eq(66666)
  #   end
  
  #   it "#find_invoiceitem_status" do
  #     expect(invoice1.find_invoiceitem_status(item1)).to eq("pending")
  #     expect(invoice1.find_invoiceitem_status(item2)).to eq("shipped")
  #     expect(invoice2.find_invoiceitem_status(item4)).to eq("packaged")
  #   end
  
  #   it "#find_invoiceitem_status" do
  #     expect(invoice1.find_invoiceitem_status(item1)).to eq("pending")
  #     expect(invoice1.find_invoiceitem_status(item2)).to eq("shipped")
  #     expect(invoice2.find_invoiceitem_status(item4)).to eq("packaged")
  #   end

  #   it "#get_total_revenue" do
  #     expect(invoice1.get_total_revenue).to eq(34907)
  #     expect(invoice2.get_total_revenue).to eq(66666)
  #   end
  end
  
  describe "Class methods" do
    let!(:merchant_a) { Merchant.create!(name: "Mr. Chant") }
  
    let!(:bulk_discount_a) { merchant_a.bulk_discounts.create!(percentage_discount: 20, quantity_threshold: 10) }

    let!(:customer_a) { Customer.create!(first_name: "A", last_name: "A") }
  
    let!(:invoice_a) { customer_a.invoices.create!() } 
  
    let!(:item_a1) { Item.create!(name: "Toy", description: "For kinder", unit_price: 200, merchant_id: merchant_a.id) }
    let!(:item_a2) { Item.create!(name: "Stapler", description: "For paper", unit_price: 400, merchant_id: merchant_a.id) }
  
  
    before do
      @invoice_item_a1 = invoice_a.invoice_items.create!( item: item_a1, quantity: 5, unit_price: 500, status: 0)
      @invoice_item_a2 = invoice_a.invoice_items.create!( item: item_a2, quantity: 5, unit_price: 600, status: 0)
    end
    # before(:each) do
    #   merchant = Merchant.create!(name: "Cabbage Merchant")
    #   dis_gai_ovah_hea = Customer.create!(first_name: "Dis", last_name: "Gai")

    #   item1 = merchant.items.create!(name: "Ramen Noodles", description: "A dang good pack-a ramen", unit_price: 99)
    #   item2 = merchant.items.create!(name: "Cabbages", description: "NOT MY CABBAGES!!!", unit_price: 500)
    #   item3 = merchant.items.create!(name: "Freesh Avacadoo", description: "Cream Freesh", unit_price: 200)

    #   @invoice1 = Invoice.create!(customer_id: dis_gai_ovah_hea.id, status: 0, created_at: Date.tomorrow )
    #   @invoice2 = Invoice.create!(customer_id: dis_gai_ovah_hea.id, status: 0, created_at: Date.yesterday )
    #   @invoice3 = Invoice.create!(customer_id: dis_gai_ovah_hea.id, status: 2 ) 

    #   InvoiceItem.create!(item_id: item1.id, invoice_id: @invoice1.id, quantity: 100, unit_price: item1.unit_price, status: 0 )
    #   InvoiceItem.create!(item_id: item2.id, invoice_id: @invoice2.id, quantity: 100, unit_price: item2.unit_price, status: 1 )
    #   InvoiceItem.create!(item_id: item3.id, invoice_id: @invoice3.id, quantity: 100, unit_price: item3.unit_price, status: 2 ) 
    # end
    #   it '.invoice_items_not_shipped' do 
    #     expect(Invoice.invoice_items_not_shipped).to eq([@invoice2, @invoice1])
    #   end

    it '#create_new_bulk_discount' do
      bulk_discount_params = {
        percentage_discount: 24,
        quantity_threshold: 711,
        merchant_id: merchant_a.id
      }
      expect(BulkDiscount.create_new_bulk_discount(bulk_discount_params)).to eq(merchant_a.bulk_discounts.last)
    end
  end
end
  