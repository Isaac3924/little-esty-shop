require 'rails_helper'
RSpec.describe "Admin Merchants Show", type: :feature do 
  let!(:bob) { Merchant.create!(name: "Bob's Beauties", status: 0) } 
  let!(:rob) { Merchant.create!(name: "Rob's Rarities", status: 0) } 
  let!(:hob) { Merchant.create!(name: "Hob's Hoootenanies", status: 0) } 
  let!(:dob) { Merchant.create!(name: "Dob's Dineries", status: 0) } 
  let!(:zob) { Merchant.create!(name: "7-11", status: 0) } 

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

  describe "As an admin" do
    context "When I visit the admin merchants index (/admin/merchants)" do
      before do
        visit admin_merchants_path
      end

      it "Sees the name of" do
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

      it "When I click on the name of a merchant" do
    
        within "#enabled_merchant-#{bob.id}" do
          click_link "Bob's Beauties"

          expect(page).to have_current_path(admin_merchant_path(bob))
        end

        visit admin_merchants_path

        within "#enabled_merchant-#{dob.id}" do
          click_link "Dob's Dineries"

          expect(page).to have_current_path(admin_merchant_path(dob))
        end
      end

      it "On the admin merchant show page, I see the name of the merchant" do
        visit admin_merchant_path(bob)

        expect(page).to have_content("Bob's Beauties")
        expect(page).to have_content("#{bob.name}")

        visit admin_merchant_path(zob)

        expect(page).to have_content("7-11")
        expect(page).to have_content("#{zob.name}")
      end

      
      it "I see a link to update the merchant's information. When I click the link, I am taken to a page to edit this merchant." do
        visit admin_merchant_path(bob)

        within('section#merchant_edit') do
          expect(page).to have_link("Edit Merchant Information for #{bob.name}")
        end

        click_link("Edit Merchant Information for #{bob.name}")

        expect(current_path).to eq(edit_admin_merchant_path(bob))
      end

      it "I see a form filled in with the existing merchant attribute information" do
        visit edit_admin_merchant_path(bob)
        
        within("form#merchant_edit_form") do
          expect(page).to have_field('Merchant Name:', with: "#{bob.name}")
        end
      end

      describe "I update the information in the form, I click ‘submit’," do
        before(:each) do
          visit edit_admin_merchant_path(bob)

          @edited_name = "Bob's Beauteez"

          fill_in 'Merchant Name:', with: "#{@edited_name}"
          click_button "Save Changes"
        end
      

        it "and I am redirected back to the merchant's admin show page." do
          expect(current_path).to eq(admin_merchant_path(bob))
        end
      
        it "I see the updated information, and I see a flash message stating that the information has been successfully updated." do
          within("header#merchant_name") do
            expect(page).to have_content("#{@edited_name}")
          end

          expect(page).to have_content("Your changes have been successfully updated")
        end
      end

      describe "I update the information incorrectly in the form, I click ‘submit’," do
        before(:each) do
          visit edit_admin_merchant_path(bob)

          @edited_name = ""

          fill_in 'Merchant Name:', with: "#{@edited_name}"
          click_button "Save Changes"
        end
      

        it "and I am redirected back to the merchant's admin edit page." do
          expect(current_path).to eq(edit_admin_merchant_path(bob))
        end
      
        it "I see a flash message stating that the information has been successfully updated." do
          expect(page).to have_content("Error")

          visit admin_merchant_path(bob)

          within("header#merchant_name") do
            expect(page).to have_content("#{bob.name}")
            expect(page).to have_content("Bob's Beauties")
          end
        end
      end
    end
  end
end
