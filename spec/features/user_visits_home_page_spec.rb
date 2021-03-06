require 'spec_helper'

feature "Home Page" do

  before do
    @mcdonalds  = FactoryGirl.create(:restaurant, :status => "approved")
    @burgerking = FactoryGirl.create(:restaurant, :name => "Burger King",
                                                  :slug => "burgerking")
  end

  scenario "user should see the most recent restaurants" do
    visit root_path
    expect(page).to have_content @mcdonalds.name
    expect(page).to have_content @burgerking.name
    expect(page).to have_link(@mcdonalds.name,
                              :href => restaurant_root_path(@mcdonalds.slug))
    expect(page).to have_link(@burgerking.name,
                              :href => restaurant_root_path(@burgerking.slug))
  end

  scenario "user clicks on restaurant and gets sent to restaurant's root" do
    visit root_path
    within '.content' do
      click_link @mcdonalds.name
    end
    expect(page).to have_content @mcdonalds.name
  end

end
