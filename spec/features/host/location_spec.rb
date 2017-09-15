require 'rails_helper'

feature "Host must be able manage locations" do
  let(:host) { FactoryGirl.create(:member) }
  let(:location) { FactoryGirl.build(:location) }

  before :each do
    visit root_path
    click_link "Sign in"
    sign_in(host)
    click_link "Locations"
  end

  scenario "host views location list" do
    expect(page).to have_content("Locations")
    expect(page).to have_css("table")
    expect(page).to have_css("th")
  end

  scenario "host creates a location" do
    expect {
      save_new_location
    }.to change(Location, :count).by(1)
    expect(page).to have_content("Location added")
    expect(page).to have_content(location.name)
  end

  scenario "host edits a location" do
    save_new_location
    expect {
      page.find('tr', text: location.name).click_link('Edit')
      fill_in "location[name]", with: "A different name"
      fill_in "location[occupancy]", with: rand(1..20)
      click_button "Save"
    }.to change(Location, :count).by(0)
    expect(page).to have_content('Location updated')
    expect(page).to have_content("A different name")
  end

  scenario "host deletes a location" do
    save_new_location
    expect {
      page.find('tr', text: location.name).click_link('Delete')
    }.to change(Location, :count).by(-1)
    expect(page).to have_content('Location deleted')
    expect(page).to_not have_content(location.name)
  end

  scenario "host navigates to photos page" do
    save_new_location
    page.find('tr', text: location.name).click_link('Edit')
    click_link "Update Photos"
    expect(page).to have_content(location.name + " photos")
  end

  scenario "host views google map" do
    save_new_location
    page.find('tr', text: location.name).click_link('Edit')
    expect(page).to have_content("Google Map")
  end

  scenario "host navigates to calendar page" do
    save_new_location
    page.find('tr', text: location.name).click_link('Edit')
    click_link "Update Availability"
    expect(page).to have_content(location.name + " availability")
  end

# utility functions

  def save_new_location
    click_button "New Location"
    fill_in_location_fields
    click_button "Save"
  end

  def fill_in_location_fields
    fill_in "location[name]", with: location.name
    select location.nearest_lake, from: "location[nearest_lake]"
    select location.loc_type, from: "location[loc_type]"
    fill_in "location[description]", with: location.description
    fill_in "location[occupancy]", with: location.occupancy
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
