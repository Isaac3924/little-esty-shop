require 'rails_helper'

RSpec.describe 'Merchants Items', type: :feature do
  let!(:sam) { Merchant.create!(name: "Sam's Sports") }

  describe 'Merchants Items New Page' do

    describe 'When I visit my merchant items new page' do
      context "When I visit the Merchant Items New Page" do

        it "When I click on the link, I am taken to a form that allows me to add item information." do
          visit merchant_items_path(sam.id)
          
          click_link "Create New Item"
          
          expect(current_path).to eq(new_merchant_item_path(sam.id))
          
          within ("section#new_item") do
            expect(page).to have_field("Name")
            expect(page).to have_field("Description")
            expect(page).to have_field("Unit Price")
            expect(page).to have_button("Submit")
          end
        end
        
        before (:each) do 
          visit new_merchant_item_path(sam.id)
        end

        it "When I fill out the form I click ‘Submit’ Then I am taken back to the items index page" do
          
          within("section#new_item") do
            fill_in "Name:", with: "Marijuana Tapestry"
            fill_in "Description", with: "Crushed velvet, 51.2 x 59.1 inches"
            fill_in "Unit Price", with: "7110"
            
            click_button "Submit"
          end

          expect(current_path).to eq(merchant_items_path(sam.id))
          
          within("div#disabled_item-#{sam.items.first.id}") do
            expect(page).to have_content(sam.items.first.name)
            expect(page).to have_button("Enable")
          end
        end

        it 'when leave a form field blank, I get an error message and am returned to that Items edit page' do
          
          within("section#new_item") do
            fill_in 'Item Name', with: 'Marijuana Tapestry'
            fill_in 'Description', with: ''
            fill_in 'Unit Price', with: ''
            click_button 'Submit'
          end

          expect(current_path).to eq(new_merchant_item_path(sam.id))
          expect(page).to have_content("Description can't be blank")
          expect(page).to have_content("Unit price can't be blank")
        end
      end
    end
  end
end