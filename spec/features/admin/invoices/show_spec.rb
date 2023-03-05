require 'rails_helper'
RSpec.describe "Admin Invoices Show", type: :feature do 
  let!(:merchant) { Merchant.create!(name: "Smiling Mask Merchant") }

  let!(:this_gai_ovah_hea) { Customer.create!(first_name: "Dis", last_name: "Gai") }

  let!(:invoice1) { Invoice.create!(customer_id: this_gai_ovah_hea.id) } 
  let!(:invoice2) { Invoice.create!(customer_id: this_gai_ovah_hea.id) } 
  let!(:invoice3) { Invoice.create!(customer_id: this_gai_ovah_hea.id) } 
  let!(:invoice4) { Invoice.create!(customer_id: this_gai_ovah_hea.id) } 
  let!(:invoice5) { Invoice.create!(customer_id: this_gai_ovah_hea.id) } 

  let!(:item1) { Item.create!(name: "Bleach", description: "Made for consumption", unit_price: 200, merchant_id: merchant.id) } 
  let!(:item2) { Item.create!(name: "Kool-Aid", description: "DO NOT CONSUME", unit_price: 20000, merchant_id: merchant.id) } 
  let!(:item3) { Item.create!(name: "All American Rejects CD", description: "Move Along Move Along Like I know You Do", unit_price: 1400, merchant_id: merchant.id) } 
  let!(:item4) { Item.create!(name: "Loofah", description: "It Loofs", unit_price: 66600, merchant_id: merchant.id) } 

  let!(:bulk_discount_50) { merchant.bulk_discounts.create!(percentage_discount: 50, quantity_threshold: 12) }
  let!(:bulk_discount_75) { merchant.bulk_discounts.create!(percentage_discount: 75, quantity_threshold: 30) }

  describe "As an admin" do
    context "When I visit the admin invoice show page" do
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

      before do
        InvoiceItem.create!(invoice: invoice1, item: item1, quantity: 30, unit_price: 336, status: 0)
        InvoiceItem.create!(invoice: invoice1, item: item2, quantity: 6, unit_price: 34571, status: 0)
        InvoiceItem.create!(invoice: invoice1, item: item3, quantity: 12, unit_price: 1599, status: 2)
        InvoiceItem.create!(invoice: invoice3, item: item1, quantity: 30, unit_price: 336, status: 0)
        InvoiceItem.create!(invoice: invoice3, item: item4, quantity: 500, unit_price: 66666, status: 1)
        
        visit admin_invoice_path(invoice1)
      end

      it "I see the invoice ID" do
        expect(page).to have_content("#{invoice1.id}")
        expect(page).to_not have_content("#{invoice2.id}")
        expect(page).to_not have_content("#{invoice5.id}")
      end

      it "I see the invoice status" do
        expect(page).to have_content("in progress")
        expect(page).to have_content("#{invoice1.status}")
      end

      it "I see the invoice created_at date in the format 'Monday, July 18, 2019'" do
        expect(page).to have_content("#{invoice1.created_at.strftime("%A, %B %d, %Y")}")
      end

      it "I see customer first and last name" do
        expect(page).to have_content("#{"Dis Gai"}")
        expect(page).to have_content("#{invoice1.customer.first_name}")
        expect(page).to have_content("#{invoice1.customer.last_name}")
      end

      it "I see all item names on the invoice" do
        expect(page).to have_content("Bleach")
        expect(page).to have_content("Kool-Aid")
        expect(page).to have_content("All American Rejects CD")
        expect(page).to have_content("#{item1.name}")
        expect(page).to have_content("#{item2.name}")
        expect(page).to have_content("#{item3.name}")

        expect(page).to_not have_content("Loofah")
        expect(page).to_not have_content("#{item4.name}")
      end

      it "I see all item quantities ordered on the invoice" do
        expect(page).to have_content("30")
        expect(page).to have_content("6")
        expect(page).to have_content("12")

        expect(page).to_not have_content("500")
      end

      it "I see all item prices they sold for(InvoiceItem table :unit_price)" do
        expect(page).to have_content("3.36")
        expect(page).to have_content("345.71")
        expect(page).to have_content("15.99")

        expect(page).to_not have_content("666.66")
      end

      it "I see all invoice item statuses" do
        expect(page).to have_content("pending")
        expect(page).to have_content("shipped")

        expect(page).to_not have_content("packaged")
      end

      it "I see the total revenue generated by this invoice" do
        expect(page).to have_content("2,366.94")
      end

      it "I see the invoice status and that its current status is selected" do
        expect(page).to have_select("invoice_status", selected: "in progress")

        visit admin_invoice_path(invoice3)
        expect(page).to have_select("invoice_status", selected: "in progress")
      end

      it "When I click this select field, I can select a new status" do
        select "completed", from: "invoice_status"
      end

      it "I see a button 'Update Invoice Status' and when I click button, I am taken to admin invoice show page" do
        select "completed", from: "invoice_status"
        click_button('Update Invoice Status')
        expect(page).to have_current_path(admin_invoice_path(invoice1))
      end

      it "Invoice status is updated to new value" do
        expect(page).to_not have_content("Status: completed")

        select "completed", from: "invoice_status"
        click_button('Update Invoice Status')

        expect(page).to have_content("Status: completed")
      end

      it 'I see the total revenue for my merchant from this invoice(without discounts), and the total discounted revenue' do
        within'section#inv_info' do
          expect(page).to have_content("Total Undiscounted Revenue: $2,366.94")
          expect(page).to have_content("Total Discounted Revenue: $2,195.40")
        end
      end

    end
  end
end