require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'relationships' do
    it { should have_many :items }
    it { should have_many :invoices }
    it { should have_many(:invoice_items).through(:items) }
  end

  let!(:this_gai_ovah_hea) { Customer.create!(first_name: "Dis", last_name: "Gai") }
  let!(:nkelthuraksyyll) { Customer.create!(first_name: "N'kelthuraksyyll", last_name: "The unboud, Lord of ten Thousand chains unBroken, Vanquisher of KMart") }
  let!(:phil) { Customer.create!(first_name: "Phil", last_name: "Phil") } 
  let!(:ahl) { Customer.create!(first_name: "Bai", last_name: "Ahl") } 

  let!(:invoice1) { Invoice.create!(customer_id: this_gai_ovah_hea.id, created_at: Date.yesterday) } 
  let!(:invoice2) { Invoice.create!(customer_id: this_gai_ovah_hea.id,  created_at: Date.tomorrow) } 
  let!(:invoice3) { Invoice.create!(customer_id: this_gai_ovah_hea.id) } 
  let!(:invoice_owl) {Invoice.create!(customer_id: nkelthuraksyyll.id, status: "cancelled") }
  let!(:invoice_sponge) {Invoice.create!(customer_id: nkelthuraksyyll.id, status: "completed") }
  let!(:invoice_vinyl) {Invoice.create!(customer_id: nkelthuraksyyll.id, status: "completed") }
  let!(:invoice_lunchbox) {Invoice.create!(customer_id: phil.id, status: "cancelled") }
  let!(:invoice_macguffin_muffins) {Invoice.create!(customer_id: phil.id, status: "completed") }
  let!(:invoice_lipstick) {Invoice.create!(customer_id: ahl.id, status: "completed") }
  let!(:invoice_ring) {Invoice.create!(customer_id: ahl.id, status: "completed") }
  let!(:invoice_stuff) {Invoice.create!(customer_id: ahl.id, status: "completed") }
  let!(:invoice_pizza) {Invoice.create!(customer_id: ahl.id, status: "completed") }
  let!(:invoice_pizza_fort) {Invoice.create!(customer_id: ahl.id, status: "completed") }
  let!(:invoice_fuzzy_pizza) {Invoice.create!(customer_id: ahl.id, status: "completed") }
  let!(:invoice_cream) {Invoice.create!(customer_id: ahl.id, status: "completed") }
  let!(:invoice_ice) {Invoice.create!(customer_id: ahl.id, status: "completed") }
  let!(:invoice_schnitzel) {Invoice.create!(customer_id: ahl.id, status: "completed") }
  let!(:invoice_taco_pizza) {Invoice.create!(customer_id: ahl.id, status: "completed") }

  let!(:sam) { Merchant.create!(name: "Sam's Sports", status: 0) }
  let!(:bob) { Merchant.create!(name: "Bob's Beauties") }
  let!(:rob) { Merchant.create!(name: "Rob's Rarities") } 
  let!(:things) { Merchant.create!(name: "Things 'n Stuff", status: 0) }
  let!(:fatty) { Merchant.create!(name: "Fatty Fartbear's Pizza Town") } 
  let!(:franklin) { Merchant.create!(name: "Franklin Facebear's Pizza Fortress") }
  let!(:fuzzy) { Merchant.create!(name: "Fuzzy Fred's Pizorium Emporium", status: 0) }
  let!(:butt) { Merchant.create!(name: "Butt Johnson's Tuna-Flavored Ice Cream Showdown") } 
  let!(:eenus) { Merchant.create!(name: "Eenus & Benus' House of Weenuhs") }
  let!(:combo) { Merchant.create!(name: "The Combination Pizza Hut and Taco Bell", status: 0) }
  
  let!(:football) { sam.items.create!(name: "Football", description: "This a football", unit_price: 3000, status: 0) }
  let!(:baseball) { sam.items.create!(name: "Baseball", description: "This a baseball", unit_price: 2500, status: 0) }
  let!(:glove) { sam.items.create!(name: "Baseball Glove", description: "This a baseball glove", unit_price: 4000, status: 1) }
  let!(:owl) { sam.items.create!(name: "Owl", description: "It eats mice. And maybe your face.", unit_price: 54999) }
  let!(:sponge) { sam.items.create!(name: "Sponge", description: "His name is Bob.", unit_price: 99) }
  let!(:vinyl) { sam.items.create!(name: "Unknown Vinyl", description: "A vinyl. Who knows what's on it?", unit_price: 999999) }
  let!(:lunchbox) { sam.items.create!(name: "Lunch Box", description: "Molded sandvich included", unit_price: 5693) }
  let!(:macguffin_muffins) { sam.items.create!(name: "The Macguffin Muffins", description: "https://youtu.be/di7DI6Q7JXA?t=39", unit_price: 99999999) }
  let!(:lipstick) { bob.items.create!(name: "Lipstick", description: "It's red flavoured", unit_price: 4500, status: 0) }
  let!(:ring) { rob.items.create!(name: "Emerald inset Ring", description: "Insert into small child's mouth", unit_price: 54705, status: 0) }
  let!(:stuff) { things.items.create!(name: "Stuff", description: "Sometimes confused with things", unit_price: 400, status: 0) }
  let!(:pizza) { fatty.items.create!(name: "Pizza", description: "Yum. If you dare.", unit_price: 6999, status: 0) }
  let!(:pizza_fort) { franklin.items.create!(name: "Pizza Fort", description: "The foundations are made of cardboard, blood, and mozzarella", unit_price: 7650, status: 0) }
  let!(:fuzzy_pizza) { fuzzy.items.create!(name: "Fuzzy Pizza", description: "It was clearly living.", unit_price: 3975, status: 0) }
  let!(:cream) { butt.items.create!(name: "Cream Tuna", description: "It isn't ice cream, nor will it be. Yet we must face hubris directly.", unit_price: 30, status: 0) }
  let!(:ice) { butt.items.create!(name: "Ice", description: "Add to cream.", unit_price: 40, status: 0) }
  let!(:schnitzel) { eenus.items.create!(name: "Schnitzel", description: "Drei Bier sind auch ein Schnitzel", unit_price: 8960, status: 0) }
  let!(:taco_pizza) { combo.items.create!(name: "Taco Pizza", description: "Pizza Taco", unit_price: 19999, status: 0) }

  let!(:transaction_football1) { invoice1.transactions.create!(result: 1) }
  let!(:transaction_baseball1) { invoice1.transactions.create!(result: 0) }
  let!(:transaction_baseball2) { invoice1.transactions.create!(result: 1) }
  let!(:transaction_glove1) { invoice2.transactions.create!(result: 0) }
  let!(:transaction_owl1) { invoice_owl.transactions.create!(result: 1) }
  let!(:transaction_sponge1) { invoice2.transactions.create!(result: 1) }
  let!(:transaction_vinyl1) { invoice_vinyl.transactions.create!(result: 0) }
  let!(:transaction_lunchbox1) { invoice_lunchbox.transactions.create!(result: 1) }
  let!(:transaction_macguffin_muffins1) { invoice_macguffin_muffins.transactions.create!(result: 0) }
  let!(:transaction_lipstick1) { invoice_lipstick.transactions.create!(result: 0) }
  let!(:transaction_ring1) { invoice_ring.transactions.create!(result: 0) }
  let!(:transaction_stuff1) { invoice_stuff.transactions.create!(result: 0) }
  let!(:transaction_pizza1) { invoice_pizza.transactions.create!(result: 0) }
  let!(:transaction_pizza_fort1) { invoice_pizza_fort.transactions.create!(result: 0) }
  let!(:transaction_fuzzy_pizza1) { invoice_fuzzy_pizza.transactions.create!(result: 0) }
  let!(:transaction_cream1) { invoice_cream.transactions.create!(result: 0) }
  let!(:transaction_ice1) { invoice_ice.transactions.create!(result: 0) }
  let!(:transaction_schnitzel1) { invoice_schnitzel.transactions.create!(result: 0) }
  let!(:transaction_taco_pizza1) { invoice_taco_pizza.transactions.create!(result: 0) }

  before (:each) do
    @football_inv = InvoiceItem.create!(invoice_id: invoice1.id, item_id: football.id, quantity: 1, unit_price: 3000, status: 0)   
    @baseball_inv = InvoiceItem.create!(invoice_id: invoice1.id, item_id: baseball.id, quantity: 10, unit_price: 96732, status: 1)  
    @glove_inv = InvoiceItem.create!(invoice_id: invoice2.id, item_id: glove.id, quantity: 1, unit_price: 4000, status: 2)         
    @glove_inv = InvoiceItem.create!(invoice_id: invoice2.id, item_id: glove.id, quantity: 2, unit_price: 4000, status: 2)                       
    @owl_inv = InvoiceItem.create!(invoice: invoice_owl, item: owl, quantity: 50000, unit_price: 51832, status: 1)                            
    @sponge_inv = InvoiceItem.create!(invoice: invoice_sponge, item: sponge, status: 0)                                                               
    @vinyl_inv = InvoiceItem.create!(invoice: invoice_vinyl, item: vinyl, quantity: 3, unit_price: 9999999, status: 2)                          
    @lunchbox_inv = InvoiceItem.create!(invoice: invoice_lunchbox, item: lunchbox, quantity: 500, unit_price: 66666, status: 1)                    
    @macguffin_muffins_inv = InvoiceItem.create!(invoice: invoice_macguffin_muffins, item: macguffin_muffins, quantity: 7, unit_price: 99999, status: 0)    
    @lipstick_inv = InvoiceItem.create!(invoice: invoice_lipstick, item: lipstick, quantity: 1, unit_price: 4674, status: 0) 
    @ring_inv = InvoiceItem.create!(invoice: invoice_ring, item: ring, quantity: 1, unit_price: 54705, status: 0)               
    @stuff_inv = InvoiceItem.create!(invoice: invoice_stuff, item: stuff, quantity: 1, unit_price: 454, status: 0)              
    @pizza_inv = InvoiceItem.create!(invoice: invoice_pizza, item: pizza, quantity: 1, unit_price: 6999, status: 0)                 
    @pizza_fort_inv = InvoiceItem.create!(invoice: invoice_pizza_fort, item: pizza_fort, quantity: 1, unit_price: 7650, status: 0)     
    @fuzzy_pizza_inv = InvoiceItem.create!(invoice: invoice_fuzzy_pizza, item: fuzzy_pizza, quantity: 1, unit_price: 3975, status: 0)  
    @cream_inv = InvoiceItem.create!(invoice: invoice_cream, item: cream, quantity: 1, unit_price: 35, status: 0) 
    @ice_inv = InvoiceItem.create!(invoice: invoice_ice, item: ice, quantity: 1, unit_price: 45, status: 0) 
    @schnitzel_inv = InvoiceItem.create!(invoice: invoice_schnitzel, quantity: 1, unit_price: 9873, item: schnitzel, status: 0)       
    @taco_pizza_inv = InvoiceItem.create!(invoice: invoice_taco_pizza, item: taco_pizza, quantity: 1, unit_price: 19999, status: 0)  
  end

  describe 'instance methods' do
    it '#merchant_invoices' do
      expect(sam.merchant_invoices).to eq([invoice1, invoice2, invoice_owl, invoice_sponge, invoice_vinyl, invoice_lunchbox, invoice_macguffin_muffins])
      expect(sam.merchant_invoices).to_not eq([invoice1, invoice1, invoice2,])

      cleats = sam.items.create!(name: "Cleats", description: "These are cleats", unit_price: 7500)
      InvoiceItem.create!(invoice_id: invoice3.id, item_id: cleats.id)

      expect(sam.merchant_invoices).to eq([invoice1, invoice2, invoice3, invoice_owl, invoice_sponge, invoice_vinyl, invoice_lunchbox, invoice_macguffin_muffins])
    end

    it '#items_not_yet_shipped' do 
      expect(sam.items_not_yet_shipped).to eq([@football_inv, @baseball_inv, @owl_inv, @sponge_inv, @lunchbox_inv, @macguffin_muffins_inv])
    end

    it '#top_5_items_by_revenue' do
      expect(sam.top_5_items_by_revenue).to eq([vinyl, baseball, macguffin_muffins, glove, football])
    end

    it '#enabled_items' do
      expect(sam.enabled_items).to eq([football, baseball, owl, sponge, vinyl, lunchbox, macguffin_muffins])
    end

    it '#disabled_items' do 
      expect(sam.disabled_items).to eq([glove])
    end
  end

  describe '.scope' do 
    it '.disabled_merchants' do 
      expect(Merchant.disabled_merchants).to eq([bob, rob, fatty, franklin, butt, eenus])
    end

    it '.enabled_merchants' do 
      expect(Merchant.enabled_merchants).to eq([sam, things, fuzzy, combo])
    end
  end

  describe 'class methods' do
    it '#top_5_merchants' do
      expect(Merchant.top_5_merchants).to eq([sam, rob, combo, eenus, franklin])
    end
  end
end
