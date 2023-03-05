require 'rails_helper'
RSpec.describe Merchant, type: :feature do 

  describe 'Merchant Dashboard' do
    let!(:louise) { Customer.create!(first_name: "Louise", last_name: "Belcher") }
    let!(:fischoeder) { Customer.create!(first_name: "Mr.", last_name: "Fischoeder") }
    let!(:jimmy) { Customer.create!(first_name: "Jimmy", last_name: "Pesto") }
    let!(:gale) { Customer.create!(first_name: "Gale", last_name: "Genarro") }
    let!(:phillip) { Customer.create!(first_name: "Phillip", last_name: "Frond") }
    let!(:labonz) { Customer.create!(first_name: "Ms.", last_name: "Labonz") }

    let!(:invoice1) { Invoice.create!(customer_id: louise.id, created_at: Date.yesterday) }
    let!(:invoice2) { Invoice.create!(customer_id: louise.id) }
    let!(:invoice3) { Invoice.create!(customer_id: louise.id) }
    let!(:invoice4) { Invoice.create!(customer_id: louise.id) }
    let!(:invoice5) { Invoice.create!(customer_id: louise.id) }
    let!(:invoice6) { Invoice.create!(customer_id: louise.id) }

    let!(:invoice7) { Invoice.create!(customer_id: fischoeder.id) }
    let!(:invoice8) { Invoice.create!(customer_id: fischoeder.id) }
    let!(:invoice9) { Invoice.create!(customer_id: fischoeder.id) }
    let!(:invoice10) { Invoice.create!(customer_id: fischoeder.id) }
    let!(:invoice11) { Invoice.create!(customer_id: fischoeder.id) }

    let!(:invoice12) { Invoice.create!(customer_id: jimmy.id) }
    let!(:invoice13) { Invoice.create!(customer_id: jimmy.id) }
    let!(:invoice14) { Invoice.create!(customer_id: jimmy.id) }
    let!(:invoice15) { Invoice.create!(customer_id: jimmy.id) }

    let!(:invoice16) { Invoice.create!(customer_id: gale.id) }
    let!(:invoice17) { Invoice.create!(customer_id: gale.id) }
    let!(:invoice18) { Invoice.create!(customer_id: gale.id) }

    let!(:invoice19) { Invoice.create!(customer_id: phillip.id) }
    let!(:invoice20) { Invoice.create!(customer_id: phillip.id) }

    let!(:invoice21) { Invoice.create!(customer_id: labonz.id) }
    let!(:invoice22) { Invoice.create!(customer_id: labonz.id) }
    
    let!(:bob) { Merchant.create!(name: "Bob's Beauties") } 
    let!(:ralph) { Merchant.create!(name: "Ralph's Beauties") } 

    let!(:coochie_copi) { bob.items.create!(name: "Coochie Copi Night Light", description: "Night Light", unit_price: 5000) }
    let!(:napkin_holder) { bob.items.create!(name: "Napkin Holder", description: "Stainless Steel Napkin Holder", unit_price: 2500) }
    let!(:knife) { bob.items.create!(name: "Knife", description: "Knife", unit_price: 3500) }
    let!(:window_planter) { bob.items.create!(name: "Window Planter", description: "Plastic Window Planter", unit_price: 2800) }
    let!(:bunny_hat) { bob.items.create!(name: "Bunny Hat", description: "Bunny Hat", unit_price: 4500) }
    let!(:grabber) { bob.items.create!(name: "Grabber", description: "Grabber", unit_price: 2700) }
    let!(:needle_point) { bob.items.create!(name: "Needle Point", description: "Top Gun Needle Point", unit_price: 2400) }
    let!(:tanning_lotion) { bob.items.create!(name: "Tanning Lotion", description: "Tanning Lotion", unit_price: 3300) }
    let!(:cat_litter) { bob.items.create!(name: "Cat Litter", description: "Cat Litter", unit_price: 3000) }
    let!(:bourbon) { bob.items.create!(name: "Bourbon", description: "That good shiii", unit_price: 6000) }

    let!(:bulk_discount20) { bob.bulk_discounts.create!(percentage_discount: 10, quantity_threshold: 20) }
    let!(:bulk_discount25) { bob.bulk_discounts.create!(percentage_discount: 15, quantity_threshold: 25) }
    let!(:bulk_discount30) { bob.bulk_discounts.create!(percentage_discount: 20, quantity_threshold: 30) }
    let!(:bulk_discount15) { ralph.bulk_discounts.create!(percentage_discount: 3, quantity_threshold: 17) }

    # before :each do
    #   repo_call = File.read('spec/fixtures/repo_call.json')
    #   collaborators_call = File.read('spec/fixtures/collaborators_call.json')
    #   pulls_call = File.read('spec/fixtures/pulls_call.json')

    #   stub_request(:get, "https://api.github.com/repos/4D-Coder/little-esty-shop").
    #       with(
    #         headers: {
    #         'Accept'=>'*/*',
    #         'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
    #         'Authorization'=>"Bearer #{ENV["github_token"]}",
    #         'User-Agent'=>'Faraday v2.7.4'
    #         }).
    #       to_return(status: 200, body: repo_call, headers: {})


    #   stub_request(:get, "https://api.github.com/repos/4D-Coder/little-esty-shop/assignees").
    #       with(
    #         headers: {
    #         'Accept'=>'*/*',
    #         'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
    #         'Authorization'=>"Bearer #{ENV["github_token"]}",
    #         'User-Agent'=>'Faraday v2.7.4'
    #         }).
    #       to_return(status: 200, body: collaborators_call, headers: {})

    #   stub_request(:get, "https://api.github.com/repos/4D-Coder/little-esty-shop/pulls?state=all&merged_at&per_page=100").
    #       with(
    #         headers: {
    #         'Accept'=>'*/*',
    #         'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
    #         'Authorization'=>"Bearer #{ENV["github_token"]}",
    #         'User-Agent'=>'Faraday v2.7.4'
    #         }).
    #       to_return(status: 200, body: pulls_call, headers: {})
    # end

    before (:each) do 
      InvoiceItem.create!(invoice_id: invoice1.id, item_id: coochie_copi.id, status: 0)
      InvoiceItem.create!(invoice_id: invoice2.id, item_id: napkin_holder.id, status: 1)
      InvoiceItem.create!(invoice_id: invoice3.id, item_id: window_planter.id, status: 2)
      InvoiceItem.create!(invoice_id: invoice7.id, item_id: grabber.id, status: 2)
      InvoiceItem.create!(invoice_id: invoice12.id, item_id: needle_point.id, status: 2)
      InvoiceItem.create!(invoice_id: invoice16.id, item_id: bourbon.id, status: 2)
      InvoiceItem.create!(invoice_id: invoice19.id, item_id: cat_litter.id, status: 2)
      InvoiceItem.create!(invoice_id: invoice21.id, item_id: tanning_lotion.id, status: 0)

      Transaction.create!(invoice_id: invoice1.id, credit_card_number: 4654405418249632, credit_card_expiration_date: "09/01/2026", result: "success")
      Transaction.create!(invoice_id: invoice2.id, credit_card_number: 4654405418249632, credit_card_expiration_date: "09/01/2026", result: "success")
      Transaction.create!(invoice_id: invoice3.id, credit_card_number: 4654405418249632, credit_card_expiration_date: "09/01/2026", result: "success")
      Transaction.create!(invoice_id: invoice4.id, credit_card_number: 4654405418249632, credit_card_expiration_date: "09/01/2026", result: "success")
      Transaction.create!(invoice_id: invoice5.id, credit_card_number: 4654405418249632, credit_card_expiration_date: "09/01/2026", result: "success")
      Transaction.create!(invoice_id: invoice6.id, credit_card_number: 4654405418249632, credit_card_expiration_date: "09/01/2026", result: "success")

      Transaction.create!(invoice_id: invoice7.id, credit_card_number: 45802512365152013, credit_card_expiration_date: "09/02/2026", result: "success")
      Transaction.create!(invoice_id: invoice8.id, credit_card_number: 45802512365152013, credit_card_expiration_date: "09/02/2026", result: "success")
      Transaction.create!(invoice_id: invoice9.id, credit_card_number: 45802512365152013, credit_card_expiration_date: "09/02/2026", result: "success")
      Transaction.create!(invoice_id: invoice10.id, credit_card_number: 45802512365152013, credit_card_expiration_date: "09/02/2026", result: "success")
      Transaction.create!(invoice_id: invoice11.id, credit_card_number: 45802512365152013, credit_card_expiration_date: "09/02/2026", result: "success")

      Transaction.create!(invoice_id: invoice12.id, credit_card_number: 45802512365152014, credit_card_expiration_date: "09/01/2027", result: "success")
      Transaction.create!(invoice_id: invoice13.id, credit_card_number: 45802512365152014, credit_card_expiration_date: "09/01/2027", result: "success")
      Transaction.create!(invoice_id: invoice14.id, credit_card_number: 45802512365152014, credit_card_expiration_date: "09/01/2027", result: "success")
      Transaction.create!(invoice_id: invoice15.id, credit_card_number: 45802512365152014, credit_card_expiration_date: "09/01/2027", result: "success")

      Transaction.create!(invoice_id: invoice16.id, credit_card_number: 45802512365152015, credit_card_expiration_date: "08/01/2026", result: "success")
      Transaction.create!(invoice_id: invoice17.id, credit_card_number: 45802512365152015, credit_card_expiration_date: "08/01/2026", result: "success")
      Transaction.create!(invoice_id: invoice18.id, credit_card_number: 45802512365152015, credit_card_expiration_date: "08/01/2026", result: "success")

      Transaction.create!(invoice_id: invoice19.id, credit_card_number: 45802512365152016, credit_card_expiration_date: "07/01/2027", result: "success")
      Transaction.create!(invoice_id: invoice20.id, credit_card_number: 45802512365152016, credit_card_expiration_date: "07/01/2027", result: "success")

      Transaction.create!(invoice_id: invoice21.id, credit_card_number: 45802512365152017, credit_card_expiration_date: "09/08/2025", result: "success")
      Transaction.create!(invoice_id: invoice22.id, credit_card_number: 45802512365152017, credit_card_expiration_date: "09/08/2025", result: "failed")

      visit merchant_dashboard_index_path(bob.id)
    end

    describe 'As a merchant' do 
      context 'When I visit merchant dashboard' do 

        it 'displays the name of my merchant' do
          expect(page).to have_content("Name: Bob's Beauties")
          expect(page).to have_content("Name: #{bob.name}")
        end

        it 'displays a link to my merchant items index' do
          expect(page).to have_link('My Items')
        end
      
        it 'displays a link to my merchant invoices index' do
          expect(page).to have_link('My Invoices')
        end

        # it 'displays the repo name on every page' do
        #   expect(page).to have_content("little-esty-shop")
        # end

        it 'see a link to view all discounts' do
          expect(page).to have_link('My Discounts')
        end

        it 'when I click the see all discounts link, I am taken to my bulk discounts index page' do
          click_link 'My Discounts'

          expect(current_path).to eq(merchant_bulk_discounts_path(bob))
        end

        it 'I see all of my bulk discounts and their corresponding percentage discounts, and quantity thresholds' do
          visit merchant_bulk_discounts_path(bob)

          expect(page).to have_link('10%')
          expect(page).to have_content("20")

          expect(page).to have_link('15%')
          expect(page).to have_content("25")

          expect(page).to have_link('20%')
          expect(page).to have_content("30")

          expect(page).to_not have_link('3%')
          expect(page).to_not have_content("17")
        end

        it 'I see a link to each bulk discount show page' do
          visit merchant_bulk_discounts_path(bob)

          click_link '10%'
          expect(current_path).to eq(merchant_bulk_discount_path(bob, bulk_discount20))

          visit merchant_bulk_discounts_path(bob)

          click_link '15%'
          expect(current_path).to eq(merchant_bulk_discount_path(bob, bulk_discount25))

          visit merchant_bulk_discounts_path(bob)

          click_link '20%'
          expect(current_path).to eq(merchant_bulk_discount_path(bob, bulk_discount30))

          expect(page).to_not have_link('3%')
        end
      end

      context 'in the section for Items Ready to Ship' do 
        it 'displays a list of names of all items that have been ordered but not shipped' do
          
          expect(page).to have_content("Items Ready to Ship")
          within "#items_and_invoices" do 
            expect(page).to have_content("Coochie Copi Night Light")
            expect(page).to have_content(coochie_copi.name)
            
            expect(page).to have_content("Napkin Holder")
            expect(page).to have_content(napkin_holder.name)

            expect(page).to_not have_content("Window Planter")
            expect(page).to_not have_content(window_planter.name)
          end
        end

        it 'displays the id of the invoice that ordered that item' do 
          within "#items_and_invoices" do 
            expect(page).to have_content("#{invoice1.id}")
            expect(page).to have_content("#{invoice2.id}")

            expect(page).to_not have_content("#{invoice3.id}")
          end
        end

        it 'displays invoice ids as a link to my merchants invoice show page next to each item' do 
          within "#items_and_invoices" do 
            click_on "#{invoice1.id}"
            expect(current_path).to eq(merchant_invoices_path(bob.id))
          end
        end

        it 'displays invoice ids as a link to my merchants invoice show page next to each item' do 
          within "#items_and_invoices" do 
            click_on "#{invoice2.id}"
            expect(current_path).to eq(merchant_invoices_path(bob.id))
          end
        end

        it 'displays the date that the invoice was created ordered by oldest to newest' do 
          within "#items_and_invoices" do 
            expect(coochie_copi.name).to appear_before(napkin_holder.name)
            expect(page).to_not have_content(window_planter.name)
          end
        end

        it 'Then I see the names of the top 5 customers' do
          within 'div#fav_customers' do
            expect(page).to have_content("Favorite Customers")
            expect(page).to_not have_content("Ms. Labonz - 1 purchases")
            expect("Louise Belcher - 6 purchases").to appear_before("Mr. Fischoeder - 5 purchases")
            expect("Mr. Fischoeder - 5 purchases").to appear_before("Jimmy Pesto - 4 purchases")
            expect("Jimmy Pesto - 4 purchases").to appear_before("Gale Genarro - 3 purchases")
            expect("Gale Genarro - 3 purchases").to appear_before("Phillip Frond - 2 purchases")
          end
        end
      end
    end
  end
end