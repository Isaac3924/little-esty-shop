require 'rails_helper'
RSpec.describe BulkDiscount, type: :feature do 

  describe 'Merchant Bulk Discount Show' do
    let!(:bob) { Merchant.create!(name: "Bob's Beauties") } 
    let!(:ralph) { Merchant.create!(name: "Ralph's Beauties") } 

    let!(:bulk_discount20) { bob.bulk_discounts.create!(percentage_discount: 10, quantity_threshold: 20) }
    let!(:bulk_discount2000) { bob.bulk_discounts.create!(percentage_discount: 79, quantity_threshold: 2000) }
    let!(:bulk_discount15) { ralph.bulk_discounts.create!(percentage_discount: 3, quantity_threshold: 17) }

    before (:each) do 
      visit "/merchants/#{bob.id}/bulk_discounts/#{bulk_discount20.id}"
    end

    describe 'As a merchant' do 
      context 'When I visit my bulk discount show page' do 

        it "I see athe bulk discount's quantity threshold and percentage discount" do
          expect(page).to have_content('Percentage Discount: 10%')
          expect(page).to have_content('Quantity Threshold: 20')

          expect(page).to_not have_content('Percentage Discount: 79%')
          expect(page).to_not have_content('Quantity Threshold: 2000')

          expect(page).to_not have_content('Percentage Discount: 3%')
          expect(page).to_not have_content('Quantity Threshold: 17')
        end
      end
    end
  end
end
