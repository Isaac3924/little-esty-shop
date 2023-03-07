require 'rails_helper'

RSpec.describe 'Admin Merchants', type: :feature do
  describe 'Admin Merchants New Page' do
    context "When I visit the Admin Merchants New Form" do
      
      before(:each) do 
        visit new_admin_merchant_path
      end
      
      it "I see a form that allows me to add merchant information." do
        visit admin_merchants_path

        click_link "Create New Merchant"

        expect(current_path).to eq(new_admin_merchant_path)
        
        within ("section#new_merchant") do
          expect(page).to have_field("Merchant Name")
          expect(page).to have_button("Submit")
        end
      end
      it "When I fill out the form I click ‘Submit’ Then I am taken back to the admin merchants index page" do
        within("section#new_merchant") do
          fill_in "Name:", with: "Tidus' Surf Shop"
    
          click_button "Submit"
        end
        
        expect(current_path).to eq(admin_merchants_path)
      end

      it 'when leave a form field blank, I get an error message and am returned to that Items edit page' do
        within("section#new_merchant") do  
          fill_in 'Merchant Name:', with: ''
          click_button 'Submit'
        end
        
        expect(current_path).to eq(new_admin_merchant_path)
        expect(page).to have_content("Name can't be blank")
      end
    end
  end
end