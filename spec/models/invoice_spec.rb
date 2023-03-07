require 'rails_helper'

RSpec.describe Invoice, type: :model do
  it { should belong_to :customer }
  it { should have_many :invoice_items }
  it { should have_many :items }
  it { should have_many :transactions }

  describe "Instance methods" do
    
    let!(:merchant) { Merchant.create!(name: "Smiling Mask Merchant") }
    let!(:merchant2) { Merchant.create!(name: "Some Guy") }
  
    let!(:this_gai_ovah_hea) { Customer.create!(first_name: "Dis", last_name: "Gai") }
  
    let!(:invoice1) { Invoice.create!(customer_id: this_gai_ovah_hea.id) } 
    let!(:invoice2) { Invoice.create!(customer_id: this_gai_ovah_hea.id) } 
    let!(:invoice3) { Invoice.create!(customer_id: this_gai_ovah_hea.id) } 

  
    let!(:item1) { Item.create!(name: "Bleach", description: "Made for consumption", unit_price: 200, merchant_id: merchant.id) } 
    let!(:item2) { Item.create!(name: "Kool-Aid", description: "DO NOT CONSUME", unit_price: 20000, merchant_id: merchant.id) } 
    let!(:item4) { Item.create!(name: "Loofah", description: "It Loofs", unit_price: 66600, merchant_id: merchant.id) } 
    let!(:item5) { Item.create!(name: "Thing", description: "Does Thing", unit_price: 6600, merchant_id: merchant.id) } 
    let!(:item6) { Item.create!(name: "Product", description: "Produces", unit_price: 100, merchant_id: merchant2.id) } 
  
    let!(:bulk_discount_1_Y) { merchant.bulk_discounts.create!(percentage_discount: 25, quantity_threshold: 3) }
    let!(:bulk_discount_1_Y_N) { merchant.bulk_discounts.create!(percentage_discount: 75, quantity_threshold: 15) }
    let!(:bulk_discount_2_Y) { merchant.bulk_discounts.create!(percentage_discount: 50, quantity_threshold: 100) }
    let!(:bulk_discount_2_N) { merchant.bulk_discounts.create!(percentage_discount: 20, quantity_threshold: 300) }
  
    before do
      InvoiceItem.create!(invoice: invoice1, item: item1, quantity: 30, unit_price: 500, status: 0)
      InvoiceItem.create!(invoice: invoice1, item: item2, quantity: 6, unit_price: 1000, status: 2)
      InvoiceItem.create!(invoice: invoice2, item: item4, quantity: 500, unit_price: 1000, status: 1)
      InvoiceItem.create!(invoice: invoice2, item: item5, quantity: 2, unit_price: 2000, status: 1)
      InvoiceItem.create!(invoice: invoice3, item: item5, quantity: 50, unit_price: 1000, status: 1)
      InvoiceItem.create!(invoice: invoice3, item: item6, quantity: 2, unit_price: 2000, status: 1)
    end
  
    it "#find_invoiceitem_quantity" do
      expect(invoice1.find_invoiceitem_quantity(item1)).to eq(30)
      expect(invoice1.find_invoiceitem_quantity(item2)).to eq(6)
      expect(invoice2.find_invoiceitem_quantity(item4)).to eq(500)
      expect(invoice2.find_invoiceitem_quantity(item5)).to eq(2)
    end
  
    it "#find_invoiceitem_unitprice" do
      expect(invoice1.find_invoiceitem_unitprice(item1)).to eq(500)
      expect(invoice1.find_invoiceitem_unitprice(item2)).to eq(1000)
      expect(invoice2.find_invoiceitem_unitprice(item4)).to eq(1000)
      expect(invoice2.find_invoiceitem_unitprice(item5)).to eq(2000)
    end
  
    it "#find_invoiceitem_status" do
      expect(invoice1.find_invoiceitem_status(item1)).to eq("pending")
      expect(invoice1.find_invoiceitem_status(item2)).to eq("shipped")
      expect(invoice2.find_invoiceitem_status(item4)).to eq("packaged")
    end
  
    it "#find_invoiceitem_status" do
      expect(invoice1.find_invoiceitem_status(item1)).to eq("pending")
      expect(invoice1.find_invoiceitem_status(item2)).to eq("shipped")
      expect(invoice2.find_invoiceitem_status(item4)).to eq("packaged")
    end

    it "#get_total_revenue" do
      expect(invoice1.get_total_revenue).to eq(21000)
      expect(invoice2.get_total_revenue).to eq(504000)
    end

    it "#get_total_discounted_amount" do
      expect(invoice1.get_total_discounted_amount).to eq(12750)
      expect(invoice2.get_total_discounted_amount).to eq(375000)
    end

    it "#get_total_revenue_from_merchant" do
      expect(invoice3.get_total_revenue_from_merchant(merchant)).to eq(50000)
    end

    it "#get_total_discounted_amount_from_merchant" do
      expect(invoice3.get_total_discounted_amount_from_merchant(merchant)).to eq(37500)
      expect(invoice3.get_total_discounted_amount_from_merchant(merchant2)).to eq(0.0)

    end
  end
  
  describe "Class methods" do
    before(:each) do
      merchant = Merchant.create!(name: "Cabbage Merchant")
      dis_gai_ovah_hea = Customer.create!(first_name: "Dis", last_name: "Gai")

      item1 = merchant.items.create!(name: "Ramen Noodles", description: "A dang good pack-a ramen", unit_price: 99)
      item2 = merchant.items.create!(name: "Cabbages", description: "NOT MY CABBAGES!!!", unit_price: 500)
      item3 = merchant.items.create!(name: "Freesh Avacadoo", description: "Cream Freesh", unit_price: 200)

      @invoice1 = Invoice.create!(customer_id: dis_gai_ovah_hea.id, status: 0, created_at: Date.tomorrow )
      @invoice2 = Invoice.create!(customer_id: dis_gai_ovah_hea.id, status: 0, created_at: Date.yesterday )
      @invoice3 = Invoice.create!(customer_id: dis_gai_ovah_hea.id, status: 2 ) 

      InvoiceItem.create!(item_id: item1.id, invoice_id: @invoice1.id, quantity: 100, unit_price: item1.unit_price, status: 0 )
      InvoiceItem.create!(item_id: item2.id, invoice_id: @invoice2.id, quantity: 100, unit_price: item2.unit_price, status: 1 )
      InvoiceItem.create!(item_id: item3.id, invoice_id: @invoice3.id, quantity: 100, unit_price: item3.unit_price, status: 2 ) 
    end
      it '.invoice_items_not_shipped' do 
        expect(Invoice.invoice_items_not_shipped).to eq([@invoice2, @invoice1])
      end
  end
end
  