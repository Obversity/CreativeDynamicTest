
feature 'Perform an import and view the results' do
  background do
    visit "/start"
    click_on 'Trigger Import'
  end

  scenario "I can see the completion confirmation screen" do
    expect(page).to have_content "Import Complete"
  end

  feature 'View all Categories' do
    background do
      visit '/'
    end

    scenario 'I can see all product categories ordered by name' do
      expect(page).to have_content "Audio"
      expect(page).to have_content "Cameras"
      expect(page).to have_content "Computers and Tablets"
      expect(page).to have_content "WhiteGoods"
    end
  end

  feature 'View Products within a Category' do
    background do
      visit "/"
      click_on "Computers and Tablets"
    end

    scenario 'I can see the first page of 5 products for the category ordered by name' do
      within 'h1' do
        expect(page).to have_content "Computers and Tablets"
      end
      expect(page).to have_content "Apple Mac Pro"
      expect(page).to have_content "Apple Macbook Pro"
      expect(page).to have_content "Apple iPad Air"
      expect(page).to have_content "Apple iPad Mini"
      expect(page).to have_content "Asus Sub-notebook"
    end

    feature 'View Page 2' do
      background do
        click_on "2"
      end

      scenario 'I can see the second page of products for the category' do
        expect(page).to have_content "Brother Laser Printer"
        expect(page).to have_content "Samsung Galaxy Tab"
        expect(page).to have_content "Seagate External HDD 1TB"
        expect(page).to have_content "Toshiba Laptop"
      end

      feature 'View a product' do
        background do
          click_on "Seagate External HDD 1TB"
        end

        scenario 'I can see the product details' do
          expect(page).to have_content "Seagate External HDD 1TB"
          expect(page).to have_content('$129')
        end
      end
    end
  end
end
