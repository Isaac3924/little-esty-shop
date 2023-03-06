require 'rails_helper'
RSpec.describe BulkDiscount, type: :feature do 

  describe 'Merchant Bulk Discount Index' do
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

      visit merchant_bulk_discounts_path(bob)
    end

    describe 'As a merchant' do 
      context 'When I visit my bulk discounts index' do 

        it 'I see a link to create a new discount' do
          expect(page).to have_link('Make New Discount')
        end

        it 'when I click the create discount link, I am taken to a new page with a form to add a new bulk discount' do
          click_link 'Make New Discount'

          expect(current_path).to eq(new_merchant_bulk_discount_path(bob))

          
          within ("section#new_bulk_discount") do
            expect(page).to have_field("Percentage Discount")
            expect(page).to have_field("Quantity Threshold")
          end
        end
        
        it 'When I fill in the form with valid data, I am redirected back to bulk_discount index and see the new bulk discount listed' do
          expect(page).to_not have_link('50%')

          click_link 'Make New Discount'
          
          within("section#new_bulk_discount") do
            fill_in "Percentage Discount:", with: 50
            fill_in "Quantity Threshold", with: 100
            
            click_button "Submit"
          end
          
          expect(current_path).to eq(merchant_bulk_discounts_path(bob))
          expect(page).to have_link('50%')
        end

        it 'next to each bulk discount I see a link to delete it' do
          within "div#bulk_discount-#{bulk_discount20.id}" do
            expect(page).to have_link('Delete')
          end

          within "div#bulk_discount-#{bulk_discount25.id}" do
            expect(page).to have_link('Delete')
          end

          within "div#bulk_discount-#{bulk_discount30.id}" do
            expect(page).to have_link('Delete')
          end
        end

        it 'When I click the delete link, I am redirected back to the bulk discounts index page, and the bulk discount is no longer present' do
          expect(page).to have_link("15%")

          within "div#bulk_discount-#{bulk_discount25.id}" do
            click_link  'Delete'
          end
          
          expect(current_path).to eq(merchant_bulk_discounts_path(bob))
          expect(page).to_not have_link('15%')
        end

        it 'I see a section with a header of "Upcoming Holidays"' do
          within "section#upcoming_holidays" do
            expect(page).to have_content("Upcoming Holidays")
          end
        end

        it 'in the Upcoming Holidays section, the name and date of the next 3 upcoming US holidays are listed' do
          within "section#upcoming_holidays" do
            expect(page).to have_content("Good Friday: 2023-04-07")
            expect(page).to have_content("Memorial Day: 2023-05-29")
            expect(page).to have_content("Juneteenth: 2023-06-19")
          end
        end
      end
    end
  end
end
