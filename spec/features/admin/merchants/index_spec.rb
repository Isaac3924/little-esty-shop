require 'rails_helper'

RSpec.describe "Admin Merchants Index", type: :feature do 
  let!(:bob) { Merchant.create!(name: "Bob's Beauties", status: 0) } 
  let!(:rob) { Merchant.create!(name: "Rob's Rarities") } 
  let!(:hob) { Merchant.create!(name: "Hob's Hoootenanies", status: 0) } 
  let!(:dob) { Merchant.create!(name: "Dob's Dineries") } 
  let!(:zob) { Merchant.create!(name: "7-11") } 
  let!(:no) { Merchant.create!(name: "Not Top 5") } 

  let!(:owl) { bob.items.create!(name: "Owl", description: "It eats mice. And maybe your face.", unit_price: 54999) }
  let!(:sponge) { rob.items.create!(name: "Sponge", description: "His name is Bob.", unit_price: 99) }
  let!(:vinyl) { hob.items.create!(name: "Unknown Vinyl", description: "A vinyl. Who knows what's on it?", unit_price: 999999) }
  let!(:lunchbox) { dob.items.create!(name: "Lunch Box", description: "Molded sandvich included", unit_price: 5693) }
  let!(:macguffin_muffins) { zob.items.create!(name: "The Macguffin Muffins", description: "https://youtu.be/di7DI6Q7JXA?t=39", unit_price: 99999999) }
  let!(:lipstick) { no.items.create!(name: "Lipstick", description: "It's red flavoured", unit_price: 4500, status: 0) }
  let!(:ring) { bob.items.create!(name: "Emerald inset Ring", description: "Insert into small child's mouth", unit_price: 54705, status: 0) }
    
  let!(:nkelthuraksyyll) { Customer.create!(first_name: "N'kelthuraksyyll", last_name: "The unboud, Lord of ten Thousand chains unBroken, Vanquisher of KMart") }
  let!(:phil) { Customer.create!(first_name: "Phil", last_name: "Phil") } 
  let!(:ahl) { Customer.create!(first_name: "Bai", last_name: "Ahl") } 

  let!(:invoice_owl) {Invoice.create!(customer_id: nkelthuraksyyll.id, status: "cancelled") }
  let!(:invoice_sponge) {Invoice.create!(customer_id: nkelthuraksyyll.id, status: "completed") }
  let!(:invoice_vinyl) {Invoice.create!(customer_id: nkelthuraksyyll.id, status: "completed") }
  let!(:invoice_lunchbox) {Invoice.create!(customer_id: phil.id, status: "cancelled") }
  let!(:invoice_macguffin_muffins) {Invoice.create!(customer_id: phil.id, status: "completed") }
  let!(:invoice_lipstick) {Invoice.create!(customer_id: ahl.id, status: "completed") }
  let!(:invoice_ring) {Invoice.create!(customer_id: ahl.id, status: "completed") }

  let!(:transaction_owl1) { invoice_owl.transactions.create!(result: 0) }
  let!(:transaction_sponge1) { invoice_sponge.transactions.create!(result: 0) }
  let!(:transaction_vinyl1) { invoice_vinyl.transactions.create!(result: 0) }
  let!(:transaction_lunchbox1) { invoice_lunchbox.transactions.create!(result: 0) }
  let!(:transaction_macguffin_muffins1) { invoice_macguffin_muffins.transactions.create!(result: 0) }
  let!(:transaction_lipstick1) { invoice_lipstick.transactions.create!(result: 0) }
  let!(:transaction_ring1) { invoice_ring.transactions.create!(result: 0) }


  describe "As an admin" do
    context "When I visit the admin merchants index (/admin/merchants)" do
      before do
        @owl_inv = InvoiceItem.create!(invoice: invoice_owl, item: owl, quantity: 1, unit_price: 5, status: 1)                            
        @sponge_inv = InvoiceItem.create!(invoice: invoice_sponge, item: sponge, quantity: 33, unit_price: 76, status: 0)                                                               
        @vinyl_inv = InvoiceItem.create!(invoice: invoice_vinyl, item: vinyl, quantity: 3, unit_price: 9999999, status: 2)                          
        @lunchbox_inv = InvoiceItem.create!(invoice: invoice_lunchbox, item: lunchbox, quantity: 500, unit_price: 1, status: 1)                    
        @macguffin_muffins_inv = InvoiceItem.create!(invoice: invoice_macguffin_muffins, item: macguffin_muffins, quantity: 7, unit_price: 99999, status: 0)    
        @lipstick_inv = InvoiceItem.create!(invoice: invoice_lipstick, item: lipstick, quantity: 3, unit_price: 100, status: 0) 
        @ring_inv = InvoiceItem.create!(invoice: invoice_ring, item: ring, quantity: 1, unit_price: 296, status: 0)
        visit admin_merchants_path
      end

      it "Sees the name of each merchant in the system" do
        expect(page).to have_content("Bob's Beauties")
        expect(page).to have_content("#{bob.name}")

        expect(page).to have_content("Rob's Rarities")
        expect(page).to have_content("#{rob.name}")

        expect(page).to have_content("Hob's Hoootenanies")
        expect(page).to have_content("#{hob.name}")

        expect(page).to have_content("Dob's Dineries")
        expect(page).to have_content("#{dob.name}")

        expect(page).to have_content("7-11")
        expect(page).to have_content("#{zob.name}")
      end

      it 'I see a link to create a new merchant' do
        within("header#admin_header") do
          expect(page).to have_link("Create New Merchant")
        end
      end

      it "When I click on the link, I am taken to a form that allows me to add merchant information." do
        click_link "Create New Merchant"

        expect(current_path).to eq(new_admin_merchant_path)
      end

      
      it 'next to each merchant I see a button to disable or enable that merchant' do

        within "div#enabled_merchant-#{bob.id}" do
          expect(page).to have_button('Disable')
        end
        within "div#enabled_merchant-#{hob.id}" do
          expect(page).to have_button('Disable')
        end
        
        within "div#disabled_merchant-#{rob.id}" do
          expect(page).to have_button('Enable')
        end
        within "div#disabled_merchant-#{dob.id}" do
          expect(page).to have_button('Enable')
        end
        within "div#disabled_merchant-#{zob.id}" do
          expect(page).to have_button('Enable')
        end
      end

      it 'displays enabled merchantsin the enabled merchants section' do
         
        within "div#enabled_merchant-#{bob.id}" do
          expect(page).to have_content(bob.name)
        end

        within "div#enabled_merchant-#{hob.id}" do
          expect(page).to have_content(hob.name)
        end

      end

      it 'displays the disabled merchants in the disabled marchants section' do
        within "div#disabled_merchant-#{rob.id}" do
          expect(page).to have_content(rob.name)
        end

        within "div#disabled_merchant-#{dob.id}" do
          expect(page).to have_content(dob.name)
        end

        within "div#disabled_merchant-#{zob.id}" do
          expect(page).to have_content(zob.name)
        end
      end

      it 'changes the status of the item after the button click' do
        within "div#enabled_merchant-#{bob.id}" do
          click_button 'Disable'
          bob.reload
          expect(bob.status).to eq('disabled')
          expect(current_path).to eq(admin_merchants_path)
        end
        
        within "div#enabled_merchant-#{hob.id}" do
          click_button 'Disable'
          hob.reload
          expect(hob.status).to eq('disabled')
          expect(current_path).to eq(admin_merchants_path)

        end

        within "div#disabled_merchant-#{rob.id}" do
          click_button 'Enable'
          rob.reload
          expect(rob.status).to eq('enabled')
          expect(current_path).to eq(admin_merchants_path)
        end

        within "div#disabled_merchant-#{dob.id}" do
          click_button 'Enable'
          dob.reload
          expect(dob.status).to eq('enabled')
          expect(current_path).to eq(admin_merchants_path)
        end

        within "div#disabled_merchant-#{zob.id}" do
          click_button 'Enable'
          zob.reload
          expect(zob.status).to eq('enabled')
          expect(current_path).to eq(admin_merchants_path)
        end
      end

      it "can see the names of the top 5 merchants ranked by total revenue generated" do
        within 'ul#top_merchant_list' do
          expect("Hob's Hoootenanies").to appear_before("7-11")
          expect("7-11").to appear_before("Rob's Rarities")
          expect("Rob's Rarities").to appear_before("Dob's Dineries")
          expect("Dob's Dineries").to appear_before("Bob's Beauties")
          expect("Bob's Beauties").to_not appear_before("Hob's Hoootenanies")
        end
      end

      it "I see that each name is a link that leads to its corresponding adminmerchant show page" do
        within 'ul#top_merchant_list' do
          click_link hob.name
          expect(current_path).to eq(admin_merchant_path(hob))
        end

        visit admin_merchants_path

        within 'ul#top_merchant_list' do
          click_link zob.name
          expect(current_path).to eq(admin_merchant_path(zob))
        end

        visit admin_merchants_path

        within 'ul#top_merchant_list' do
          click_link rob.name
          expect(current_path).to eq(admin_merchant_path(rob))
        end

        visit admin_merchants_path

        within 'ul#top_merchant_list' do
          click_link dob.name
          expect(current_path).to eq(admin_merchant_path(dob))
        end

        visit admin_merchants_path

        within 'ul#top_merchant_list' do
          click_link bob.name
          expect(current_path).to eq(admin_merchant_path(bob))
        end

        visit admin_merchants_path
      end

      it "I see the total revenue generated next to each of the merchants" do
        expect(page).to have_content("Hob's Hoootenanies $299,999.97")
        expect(page).to have_content("7-11 $6,999.93")
        expect(page).to have_content("Rob's Rarities $25.08")
        expect(page).to have_content("Dob's Dineries $5.00")
        expect(page).to have_content("Bob's Beauties $3.01")
      end
    end
  end
end