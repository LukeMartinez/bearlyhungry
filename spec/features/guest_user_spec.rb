require 'spec_helper'
require 'capybara/rails'
require 'capybara/rspec'

describe "Guest User" do

  before do
    @item = FactoryGirl.create(:item, title: "Item 1")
  end

  it "can review order and see 'continue as guest button'" do
    page.visit menu_path
    click_on 'Add to Cart'
    click_on 'Checkout'
    expect(page.current_path).to eq(review_order_path)
    expect(page).to have_button "Continue as Guest"
  end

  it "can checkout as a guest user" do
    pending
    click_on "Continue As Guest"
    fill_in 'full-name',             with: 'Test User'
    fill_in 'email-address',         with: 'test@example.com'
    fill_in 'phone-number',          with: '1234567890'
    click_on 'proceed'
    #credit card thingy
  end

  # it "can't signup a user with incorrect attributes" do
  #   page.visit menu_path
  #   expect(page).not_to have_content "Account"
  #   within '#signupTab' do
  #     fill_in 'full-name',             with: 'Test User'
  #     fill_in 'email-address',         with: 'test@example.com'
  #     fill_in 'password',              with: 'password'
  #     fill_in 'password-confirmation', with: 'NON MATCHING SUCKA?!'
  #     click_on 'signup-submit'
  #   end
  #   expect(page).to_not have_content "Logout"
  #   expect(page).to have_content
  #     "Password Confirmation doesn't match password"
  # end
end