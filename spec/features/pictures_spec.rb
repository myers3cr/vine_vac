require 'rails_helper'

feature "Host must be able to add a photo to a location" do 
  let(:host) { FactoryGirl.create(:member) }
  let(:location) { FactoryGirl.build(:location) }

  before :each do
    visit root_path
    click_link "Sign in"
    sign_in(host)
    click_link "Locations"
    save_new_location
    page.find('tr', text: location.name).click_link('Edit')
  end
 
  scenario "host adds a photo" do
      click_link "Update Photos"
      expect(page).to_not have_css("div.item > img")
      attach_file "images[]", "spec/files/cabin.png"
      click_button "Done"
      page.find('tr', text: location.name).click_link('Edit')
      expect(page).to have_css("div.item > img")
  end

  # scenario "host edits a photo" do
  # end

  # scenario "host deletes a photo" do
  # end

  def save_new_photo
  end

  def save_new_location
    click_button "New Location"
    fill_in_location_fields
    click_button "Save"
  end

  def fill_in_location_fields
    select location.loc_type, from: "location[loc_type]"
    fill_in "location[name]", with: location.name
    fill_in "location[description]", with: location.description
    fill_in "location[occupancy]", with: rand(1..20)
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