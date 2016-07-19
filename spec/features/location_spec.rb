require 'rails_helper'

feature "Host must be able to add a location" do 
  let(:host) { FactoryGirl.create(:member) }
  let(:location) { FactoryGirl.build(:location) }

  before :each do
    visit root_path
    click_link "Sign in"
    sign_in(host)
    click_link "Locations"
  end
  
  scenario "host views location list" do
    expect(page).to have_content("My Locations")
    expect(page).to have_css("table")
    expect(page).to have_css("th")
  end

  scenario "host creates a location" do
    before_count = Location.count
    click_button "New Location"
    fill_in_location_fields
    click_button "Save"
    expect(page).to have_content("Location added")
    expect(page).to have_content(location.name)
    expect(Location.count).to eq before_count + 1
  end

  scenario "host edits a location" do
    click_button "New Location"
    fill_in_location_fields
    click_button "Save"
    before_count = Location.count
    page.find('tr', text: location.name).click_link('Edit')
    fill_in "location[name]", with: "A different name"
    click_button "Save"
    expect(page).to have_content('Location updated')
    expect(page).to have_content("A different name")
    expect(Location.count).to eq before_count
  end

  scenario "host deletes a location" do
    click_button "New Location"
    fill_in_location_fields
    click_button "Save"
    before_count = Location.count
    page.find('tr', text: location.name).click_link('Delete')
    expect(page).to have_content('Location deleted')
    expect(page).to_not have_content(location.name)
    expect(Location.count).to eq before_count - 1 
  end

  def fill_in_location_fields
    fill_in "location[name]", with: location.name
    fill_in "location[description]", with: location.description
    fill_in "location[address_1]", with: location.address_1
    fill_in "location[address_2]", with: location.address_2
    fill_in "location[city]", with: location.city
    fill_in "location[state]", with: location.state
    fill_in "location[postal_code]", with: location.postal_code
  end

  def sign_in(who)
    fill_in "member[email]", with: who.email
    fill_in "member[password]", with: who.password
    click_button "Sign in"
  end

end