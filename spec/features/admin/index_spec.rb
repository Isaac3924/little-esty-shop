require 'rails_helper'

RSpec.describe 'Admin Dashboard:', type: :feature do 
  before(:each) do
    merchant = Merchant.create!(name: "Cabbage Merchant")
    dis_gai_ovah_hea = Customer.create!(first_name: "Dis", last_name: "Gai")
    
    item1 = merchant.items.create!(name: "Ramen Noodles", description: "A dang good pack-a ramen", unit_price: 99)
    item2 = merchant.items.create!(name: "Cabbages", description: "NOT MY CABBAGES!!!", unit_price: 500)
    item3 = merchant.items.create!(name: "Freesh Avacadoo", description: "Cream Freesh", unit_price: 200)
    
    @invoice1 = Invoice.create!(customer_id: dis_gai_ovah_hea.id, status: 0 )
    @invoice2 = Invoice.create!(customer_id: dis_gai_ovah_hea.id, status: 0 )
    @invoice3 = Invoice.create!(customer_id: dis_gai_ovah_hea.id, status: 2 ) 
    
    InvoiceItem.create!(item_id: item1.id, invoice_id: @invoice1.id, quantity: 100, unit_price: item1.unit_price, status: 0 )
    InvoiceItem.create!(item_id: item2.id, invoice_id: @invoice2.id, quantity: 100, unit_price: item2.unit_price, status: 1 )
    InvoiceItem.create!(item_id: item3.id, invoice_id: @invoice3.id, quantity: 100, unit_price: item3.unit_price, status: 2 )
    
    visit '/admin'  
  end

  describe 'As an Admin,' do
    context 'when I visit the admin dashboard (/admin),' do
      it 'I see a header indicating that I am on the admin dashboard.' do
        
        expect(current_path).to eq('/admin')

        within('#admin_header') do
          expect(page).to have_content("Admin Dashboard")
        end
      end

      it 'I see a link to the admin merchants index (/admin/merchants), and a link to the admin invoices index (/admin/invoices)' do
        
        within('#admin_nav') do
          expect(page).to have_link('Merchants')
          expect(page).to have_link('Invoices')
        end
      end

      it "I see a section for 'Incomplete Invoices'," do

        within 'section#incomplete_invoices' do
          expect(page).to have_content("Incomplete Invoices")
        end
      end

      it "In that section I see a list of the ids of all invoices that have items that have not yet been shipped" do

        within('section#incomplete_invoices') do
          expect(page).to have_link("#{@invoice1.id}")
          expect(page).to have_link("#{@invoice2.id}")
          expect(page).to_not have_link("#{@invoice3.id}")
        end
      end

      it "And each invoice id links to that invoice's admin show page." do

        click_link "#{@invoice1.id}"
        expect(current_path).to eq("/admin/invoices/#{@invoice1.id}")
       
        visit '/admin'
        click_link "#{@invoice2.id}"
        expect(current_path).to eq("/admin/invoices/#{@invoice2.id}")
      end
    end
  end
end