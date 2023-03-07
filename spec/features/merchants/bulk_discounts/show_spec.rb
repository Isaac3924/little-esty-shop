require 'rails_helper'
RSpec.describe BulkDiscount, type: :feature do 

  describe 'Merchant Bulk Discount Show' do
    let!(:bob) { Merchant.create!(name: "Bob's Beauties") } 
    let!(:ralph) { Merchant.create!(name: "Ralph's Beauties") } 

    let!(:bulk_discount20) { bob.bulk_discounts.create!(percentage_discount: 10, quantity_threshold: 20) }
    let!(:bulk_discount2000) { bob.bulk_discounts.create!(percentage_discount: 79, quantity_threshold: 2000) }
    let!(:bulk_discount15) { ralph.bulk_discounts.create!(percentage_discount: 3, quantity_threshold: 17) }

    before (:each) do 
      visit merchant_bulk_discount_path(bob, bulk_discount20)
    end

    describe 'As a merchant' do 
      context 'When I visit my bulk discount show page' do 

        it "I see the bulk discount's quantity threshold and percentage discount" do
          expect(page).to have_content('Percentage Discount: 10%')
          expect(page).to have_content('Quantity Threshold: 20')

          expect(page).to_not have_content('Percentage Discount: 79%')
          expect(page).to_not have_content('Quantity Threshold: 2000')

          expect(page).to_not have_content('Percentage Discount: 3%')
          expect(page).to_not have_content('Quantity Threshold: 17')
        end

        it "I see a link to edit the bulk discount" do
          expect(page).to have_link('Edit')
        end

        it "When I click the Edit link, I am taken to a new page with a form to edit the bulk_discount and that the curren attributes are pre-populated in the form" do
          click_link 'Edit'

          expect(current_path).to eq(edit_merchant_bulk_discount_path(bob, bulk_discount20))

          within ("section#edit_bulk_discount") do
            expect(page).to have_field("Percentage Discount", with: '10')
            expect(page).to have_field("Quantity Threshold", with: '20')
          end
        end

        it "When I change any/all information and click submit, I am taken back to the show page and see the attributes have been updated" do
          expect(page).to have_content('Percentage Discount: 10%')
          expect(page).to have_content('Quantity Threshold: 20')

          click_link 'Edit'

          within ("section#edit_bulk_discount") do
            fill_in 'Percentage Discount', with: 99
            fill_in 'Quantity Threshold', with: 3
            click_button 'Submit'
          end

          expect(current_path).to eq(merchant_bulk_discount_path(bob, bulk_discount20))
          expect(page).to have_content('Percentage Discount: 99%')
          expect(page).to have_content('Quantity Threshold: 3')
        end

        it "When I change any/all information into dad data and click submit, I am taken back to the edit page" do
          expect(page).to have_content('Percentage Discount: 10%')
          expect(page).to have_content('Quantity Threshold: 20')

          click_link 'Edit'

          within ("section#edit_bulk_discount") do
            fill_in 'Percentage Discount', with: "WRONG"
            fill_in 'Quantity Threshold', with: "DATA"
            click_button 'Submit'
          end

          expect(current_path).to eq(edit_merchant_bulk_discount_path(bob, bulk_discount20))
        end
      end
    end
  end
end
