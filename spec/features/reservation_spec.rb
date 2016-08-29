require 'rails_helper'

feature "Member must be able to add a reservation" do 
  let!(:me) { FactoryGirl.create(:member) }
  let!(:other_member) { FactoryGirl.create(:member) }
  let(:location1) { FactoryGirl.create(:location, member: other_member) }
  let(:location2) { FactoryGirl.create(:location, member: other_member) }
  let(:reservation) { FactoryGirl.build(:reservation, member: me) }

  before do
    visit root_path
    click_link "Sign in"
    sign_in(me)
  end

  before :each do
    # visit root_path
    # click_link "Sign in"
    # sign_in(me)
    location1.save
    location2.save
    click_link "Reservations"
  end
  
  scenario "member views empty reservation list" do
    expect(page).to have_content("My Reservations")
    expect(page).to_not have_css("table")
    expect(page).to have_text("No current reservations")
  end

  scenario "member creates a reservation and views non-empty list" do
    expect {
      save_new_reservation(location1)
    }.to change(Reservation, :count).by(1)
    expect(page).to have_content("Reservation added")
    expect(page).to have_content("My Reservations")
    expect(page).to have_css("table > thead > tr", text: "Location")
    expect(page).to have_css("table > thead > tr", text: "Start date")
    expect(page).to have_css("table > thead > tr", text: "End date")
    expect(page).to have_content(location1.name)
    expect(page).to have_content(reservation.start_date)
    expect(page).to have_content(reservation.end_date)
 end

  scenario "member edits a reservation location" do
    save_new_reservation(location1)
    expect {
      page.find('tr', text: location1.name).click_link('Edit')
      select location2.name, from: "Location"
      click_button "Save"
    }.to change(Reservation, :count).by(0)
    expect(page).to have_content('Reservation updated')
    expect(page).to have_content(location2.name)
  end

  scenario "member edits reservation dates" do
    save_new_reservation(location1)
    expect {
      page.find('tr', text: location1.name).click_link('Edit')
      fill_in "reservation[start_date]", with: reservation.start_date + 1.week
      fill_in "reservation[end_date]", with: reservation.end_date + 1.week
      click_button "Save"
    }.to change(Reservation, :count).by(0)
    expect(page).to have_content('Reservation updated')
    expect(page).to have_content(reservation.start_date + 7.days)
    expect(page).to have_content(reservation.end_date + 7.days)
  end

  scenario "member deletes a reservation" do
    save_new_reservation(location1)
    save_new_reservation(location2)
    expect {
      page.find('tr', text: location1.name).click_link('Delete')
    }.to change(Reservation, :count).by(-1)
    expect(page).to have_content('Reservation deleted')
    expect(page).to_not have_content(location1.name)
    expect(page).to have_content(location2.name)
  end

# utility methods

  def save_new_reservation(loc)
    click_button "New Reservation"
    fill_in_reservation_fields(loc)
    click_button "Save"
  end

  def fill_in_reservation_fields(loc)
    select loc.name, from: "Location"
    fill_in "reservation[start_date]", with: reservation.start_date
    fill_in "reservation[end_date]", with: reservation.end_date
  end

  def select_by_id(id, options = {})
    field = options[:from]
    option_xpath = "//*[@id='#{field}']/option[#{id}]"
    option_text = find(:xpath, option_xpath).text
    select option_text, :from => field
  end

  def select_date(date, options = {})
    field = options[:from]
    select date.year,   :from => "#{field}_1i"
    select_by_id date.month, :from => "#{field}_2i"
    select date.day,    :from => "#{field}_3i"  
  end

  def sign_in(who)
    fill_in "member[email]", with: who.email
    fill_in "member[password]", with: who.password
    click_button "Sign in"
  end

end