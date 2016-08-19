require 'rails_helper'

feature "Member must be able to add a reservation" do 
  let(:member) { FactoryGirl.create(:member) }
  let(:location) { FactoryGirl.create(:location) }
  let(:reservation) { FactoryGirl.build(:reservation) }

  before :each do
    visit root_path
    click_link "Sign in"
    sign_in(member)
    click_link "Reservations"
  end
  
  scenario "member views location list" do
    expect(page).to have_content("Available Locations")
    expect(page).to have_css("table")
    expect(page).to have_css("th")
  end

  scenario "member creates a reservation" do
    expect {
      save_new_reservation
    }.to change(Reservation, :count).by(1)
    expect(page).to have_content("Reservation added")
    expect(page).to have_content(reservation.name)
  end

  scenario "member edits a reservation" do
    save_new_location
    expect {
      page.find('tr', text: location.name).click_link('Edit')
      fill_in "location[name]", with: "A different name"
      click_button "Save"
    }.to change(Location, :count).by(0)
    expect(page).to have_content('Location updated')
    expect(page).to have_content("A different name")
  end

  scenario "member deletes a reservation" do
    save_new_reservation
    expect {
      page.find('tr', text: location.name).click_link('Delete')
    }.to change(Location, :count).by(-1)
    expect(page).to have_content('Reservation deleted')
    expect(page).to_not have_content(location.name)
  end

   def save_new_reservation
    page.find('tr', text: location.name).click_link('Reserve')
    click_button "New Reservation"
    fill_in_reservation_fields
    click_button "Save"
  end

  def fill_in_reservation_fields
    fill_in "reservation[start_date]", with: reservation.start_date
    fill_in "reservation[end_date]", with: reservation.end_date
  end

  def sign_in(who)
    fill_in "member[email]", with: who.email
    fill_in "member[password]", with: who.password
    click_button "Sign in"
  end

end