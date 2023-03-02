require 'rails_helper'

RSpec.describe 'Admin Merchants', type: :feature do
  describe 'Admin Merchants New Page' do
    context "When I visit the Admin Merchants New Form" do
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