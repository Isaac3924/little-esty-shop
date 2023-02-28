require 'rails_helper'

RSpec.describe 'Admin Merchants', type: :feature do
  describe 'Admin Merchants New' do
    context "When I visit the Admin Merchants New Form" do
      before(:each) do 
        visit new_admin_merchant_path
      end

      it "When I click on the link, I am taken to a form that allows me to add merchant information." do
        click_link "Create New Merchant"

        expect(current_path).to eq(new_admin_merchant_path)

        within ("section#new_admin_merchant") do
          expect(page).to have_field("Name")
        end
      end
    
      it "When I fill out the form I click ‘Submit’ Then I am taken back to the admin merchants index page" do
        within("section#new_merchant") do
          fill_in "Name:", with: "Tidus' Surf Shop"
    
          click_button "Submit"
        end
        
        expect(current_path).to eq(admin_merchants_path)
      end
    end
  end
end