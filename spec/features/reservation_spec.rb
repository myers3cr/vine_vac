require 'rails_helper'

feature "Member must be able to add a reservation", js: true do
  let!(:me) { create(:member) }
  let!(:other_member) { create(:member) }
  let!(:location1) { create(:location, member: other_member) }
  let!(:location2) { create(:location, member: other_member) }
  let(:reservation) { build(:reservation, member: me) }

  before :each do
    visit root_path
    click_link "Sign in"
    sign_in(me)
    click_link "Reservations"
  end

  scenario "member views empty reservation list" do
    expect(page).to have_content("My Reservations")
    expect(page).to_not have_css("table")
    expect(page).to have_text("No current reservations")
  end

  scenario "member creates a reservation and views non-empty list" do
    expect {
      save_new_reservation(location1, reservation)
    }.to change(Reservation, :count).by(1)
    expect(page).to have_content("Reservation added")
    expect(page).to have_content("My Reservations")
    expect(page).to have_css("table > thead > tr", text: "Location")
    expect(page).to have_css("table > thead > tr", text: "Guests")
    expect(page).to have_css("table > thead > tr", text: "Check-in date")
    expect(page).to have_css("table > thead > tr", text: "Check-out date")
    expect(page).to have_content(good_location.name)
    expect(page).to have_content(reservation.start_date)
    expect(page).to have_content(reservation.end_date)
 end

  # scenario "member edits a reservation location" do
  #   pending
  #   save_new_reservation(location1, reservation)
  #   expect {
  #     page.find('tr', text: location1.name).click_link('Edit')
  #     select location2.name, from: "Location"
  #     click_button "Save"
  #   }.to change(Reservation, :count).by(0)
  #   expect(page).to have_content('Reservation updated')
  #   expect(page).to have_content(location2.name)
  # end
  #
  # scenario "member edits reservation dates" do
  #   pending
  #   save_new_reservation(location1, reservation)
  #   expect {
  #     page.find('tr', text: location1.name).click_link('Edit')
  #     fill_in "reservation[start_date]", with: reservation.start_date + 1.week
  #     fill_in "reservation[end_date]", with: reservation.end_date + 1.week
  #     create_availabilities(reservation.start_date+1.week, reservation.end_date+1.week)
  #     click_button "Save"
  #   }.to change(Reservation, :count).by(0)
  #   expect(page).to have_content('Reservation updated')
  #   expect(page).to have_content(reservation.start_date + 7.days)
  #   expect(page).to have_content(reservation.end_date + 7.days)
  # end
  #
  # scenario "member deletes a reservation" do
  #   pending
  #   save_new_reservation(location1, reservation)
  #   save_new_reservation(location2, reservation)
  #   expect {
  #     page.find('tr', text: location1.name).click_link('Delete')
  #   }.to change(Reservation, :count).by(-1)
  #   expect(page).to have_content('Reservation deleted')
  #   expect(page).to_not have_content(location1.name)
  #   expect(page).to have_content(location2.name)
  # end
  #
  # scenario "member creates a reservation on an unavailable day" do
  #   pending
  #   expect {
  #     save_new_reservation(location1, bad_reservation)
  #   }.to change(Reservation, :count).by(0)
  # end

# utility methods

  def save_new_reservation(loc, res)
    click_button "New Reservation"
    select loc.name, from: "Location"
    fill_in "reservation[occupancy]", with: res.occupancy
    fill_in "reservation[start_date]", with: res.start_date
    fill_in "reservation[end_date]", with: res.end_date
    click_button "Save"
  end

  def sign_in(who)
    fill_in "member[email]", with: who.email
    fill_in "member[password]", with: who.password
    click_button "Sign in"
  end

end
