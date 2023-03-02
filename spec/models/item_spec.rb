require 'rails_helper'

RSpec.describe Item, type: :model do
  it { should belong_to :merchant } 
  it { should have_many :invoice_items }
  it { should have_many :invoices }
  it { should validate_presence_of :name}
  it { should validate_presence_of :description}
  it { should validate_presence_of :unit_price }

  let!(:bob) { Merchant.create!(name: "Bob's Beauties") } 
  let!(:sam) { Merchant.create!(name: "Sam's Sports") } 

  let!(:dingus) { Customer.create!(first_name: "Dingus", last_name: "Goofsshwertz") }
  let!(:moira) { Customer.create!(first_name: "Moira", last_name: "Rose") }

  
  let!(:item1) { bob.items.create!(name: "item 1", description: "This item 1", unit_price: 600) }
  let!(:item2) { bob.items.create!(name: "item 2", description: "This item 2", unit_price: 500) }
  let!(:item3) { bob.items.create!(name: "item 3", description: "This item 3", unit_price: 400) }
  let!(:item4) { bob.items.create!(name: "item 4", description: "This item 4", unit_price: 300) }
  let!(:item5) { bob.items.create!(name: "item 5", description: "This item 5", unit_price: 200) }
  let!(:item6) { sam.items.create!(name: "item 6", description: "This item 6", unit_price: 200) }
  let!(:item7) { sam.items.create!(name: "item 7", description: "This item 7", unit_price: 100) }
  
  let!(:invoice1) {Invoice.create!(customer_id: dingus.id, status: 2, created_at: Date.new(2022, 1, 1)) }
  let!(:invoice2) {Invoice.create!(customer_id: dingus.id, status: 2, created_at: Date.new(2022, 1, 2)) }
  let!(:invoice3) {Invoice.create!(customer_id: moira.id, status: 2, created_at: Date.new(2022, 1, 3)) }
  let!(:invoice4) {Invoice.create!(customer_id: dingus.id, status: 2, created_at: Date.new(2022, 2, 1)) }
  let!(:invoice5) {Invoice.create!(customer_id: dingus.id, status: 2, created_at: Date.new(2022, 2, 2)) }
  let!(:invoice6) {Invoice.create!(customer_id: dingus.id, status: 2, created_at: Date.new(2022, 2, 3)) }
  let!(:invoice7) {Invoice.create!(customer_id: moira.id, status: 2, created_at: Date.new(2022, 3, 1)) }
  let!(:invoice8) {Invoice.create!(customer_id: dingus.id, status: 2, created_at: Date.new(2022, 3, 2)) }
  let!(:invoice9) {Invoice.create!(customer_id: dingus.id, status: 2, created_at: Date.new(2022, 3, 3)) }
  let!(:invoice10) {Invoice.create!(customer_id: moira.id, status: 2, created_at: Date.new(2022, 4, 1)) }
  let!(:invoice11) {Invoice.create!(customer_id: dingus.id, status: 2, created_at: Date.new(2022, 4, 2)) }
  let!(:invoice12) {Invoice.create!(customer_id: dingus.id, status: 2, created_at: Date.new(2022, 4, 3)) }

  let!(:transaction1) { invoice1.transactions.create!(result: 0) }
  let!(:transaction2) { invoice2.transactions.create!(result: 0) }
  let!(:transaction3) { invoice3.transactions.create!(result: 0) }
  let!(:transaction4) { invoice4.transactions.create!(result: 0) }
  let!(:transaction5) { invoice5.transactions.create!(result: 0) }
  let!(:transaction6) { invoice6.transactions.create!(result: 0) }
  let!(:transaction7) { invoice7.transactions.create!(result: 0) }
  let!(:transaction8) { invoice8.transactions.create!(result: 0) }
  let!(:transaction9) { invoice9.transactions.create!(result: 0) }
  let!(:transaction10) { invoice10.transactions.create!(result: 0) }
  let!(:transaction11) { invoice11.transactions.create!(result: 0) }
  let!(:transaction12) { invoice12.transactions.create!(result: 0) }

  before (:each) do 
    @cool_dude = Merchant.create!(name: "Cool Dude's Trippy Emporium")
    InvoiceItem.create!(invoice: invoice1, item: item6, quantity: 15, unit_price: 900, status: 2)            
    InvoiceItem.create!(invoice: invoice2, item: item5, quantity: 15, unit_price: 800, status: 2)               
    InvoiceItem.create!(invoice: invoice3, item: item4, quantity: 15, unit_price: 700, status: 2)         
    InvoiceItem.create!(invoice: invoice4, item: item3, quantity: 10, unit_price: 600, status: 2)        
    InvoiceItem.create!(invoice: invoice5, item: item2, quantity: 10, unit_price: 500, status: 2)               
    InvoiceItem.create!(invoice: invoice6, item: item1, quantity: 10, unit_price: 400, status: 2)             
    InvoiceItem.create!(invoice: invoice7, item: item6, quantity: 10, unit_price: 300, status: 2)           
    InvoiceItem.create!(invoice: invoice8, item: item5, quantity: 10, unit_price: 400, status: 2)            
    InvoiceItem.create!(invoice: invoice9, item: item4, quantity: 10, unit_price: 500, status: 2)     
    InvoiceItem.create!(invoice: invoice10, item: item3, quantity: 10, unit_price: 600, status: 2)  
    InvoiceItem.create!(invoice: invoice11, item: item2, quantity: 10, unit_price: 700, status: 2)  
    InvoiceItem.create!(invoice: invoice12, item: item7, quantity: 10, unit_price: 800, status: 2)  
  end
  
  describe '#create_new_item()' do
    it "creates a new item in the database assigned to a specific merchant" do 
      item_params = {
        name: "Marijuana Tapestry",
        description: "Crushed velvet, 51.2 x 59.1 inches",
        unit_price: 7110,
        merchant_id: @cool_dude.id
      }
      expect(Item.create_new_item(item_params)).to eq(@cool_dude.items.last)
    end

    describe '#instance_methods' do
      it '#best_day' do
        expect(item1.best_day).to eq('2022-02-03 00:00:00 UTC')
        expect(item2.best_day).to eq('2022-04-02 00:00:00 UTC')
        expect(item4.best_day).to eq('2022-01-03 00:00:00 UTC')
        expect(item5.best_day).to eq('2022-01-02 00:00:00 UTC')
        expect(item6.best_day).to eq('2022-01-01 00:00:00 UTC')
        expect(item7.best_day).to eq('2022-04-03 00:00:00 UTC')
        expect(item3.best_day).to eq('2022-04-01 00:00:00 UTC')
        expect(item3.best_day).to_not eq('2022-02-01 00:00:00 UTC')
      end
    end
  end
end
