require 'rails_helper'

RSpec.describe 'Merchants Items', type: :feature do
  let!(:sam) { Merchant.create!(name: "Sam's Sports") }

  describe 'Merchants Items New Page' do
    describe 'When I visit my merchant items new page' do
      context "When I visit the Merchant Items New Page" do

        before :each do
          repo_call = File.read('spec/fixtures/repo_call.json')
          collaborators_call = File.read('spec/fixtures/collaborators_call.json')
          pulls_call = File.read('spec/fixtures/pulls_call.json')

          stub_request(:get, "https://api.github.com/repos/4D-Coder/little-esty-shop").
              with(
                headers: {
                'Accept'=>'*/*',
                'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
                'Authorization'=>"Bearer #{ENV["github_token"]}",
                'User-Agent'=>'Faraday v2.7.4'
                }).
              to_return(status: 200, body: repo_call, headers: {})


          stub_request(:get, "https://api.github.com/repos/4D-Coder/little-esty-shop/assignees").
              with(
                headers: {
                'Accept'=>'*/*',
                'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
                'Authorization'=>"Bearer #{ENV["github_token"]}",
                'User-Agent'=>'Faraday v2.7.4'
                }).
              to_return(status: 200, body: collaborators_call, headers: {})

          stub_request(:get, "https://api.github.com/repos/4D-Coder/little-esty-shop/pulls?state=all&merged_at&per_page=100").
              with(
                headers: {
                'Accept'=>'*/*',
                'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
                'Authorization'=>"Bearer #{ENV["github_token"]}",
                'User-Agent'=>'Faraday v2.7.4'
                }).
              to_return(status: 200, body: pulls_call, headers: {})
        end
        
        before (:each) do 
          visit new_merchant_item_path(sam.id)
        end
        
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
        

        it "When I fill out the form I click 'Submit' Then I am taken back to the items index page" do
          
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