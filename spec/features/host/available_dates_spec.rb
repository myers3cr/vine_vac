require 'rails_helper'

feature "Host must be able to manage available dates" do 
  let!(:host) { FactoryGirl.create(:member) }
  let!(:location) { FactoryGirl.create(:location, member: host) }
  let(:available) { FactoryGirl.build(:available_date) }

  before :each do
    visit root_path
    click_link "Sign in"
    sign_in(host)
    click_link "Locations"
  end
  
  scenario "host views empty available date list" do
    page.find('tr', text: location.name).click_link('Edit')
    click_link "Update Availability"
    expect(page).to have_content(location.name + " availability")
    expect(page).to_not have_css("table")
    expect(page).to have_text("This location is not currently available to the public.")
  end

  scenario "host creates a single availabie date and views non-empty list" do
    page.find('tr', text: location.name).click_link('Edit')
    click_link "Update Availability"
    expect {
      save_new_available_date
    }.to change(AvailableDate, :count).by(1)
    expect(page).to have_content("Available dates added")
    expect(page).to have_css("table > thead > tr", text: "Date")
    expect(page).to have_css("table > thead > tr", text: "Status")
    expect(page).to have_css("table > thead > tr", text: "Price")
    expect(page).to have_content(available.available_date)
    expect(page).to have_content(available.status)
    expect(page).to have_content(available.price)
  end

  scenario "host adds a range of dates" do
    page.find('tr', text: location.name).click_link('Edit')
    click_link "Update Availability"
    expect {
      save_new_available_date_range
    }.to change(AvailableDate, :count).by(8)
    expect(page).to have_content("Available dates added")
    expect(page).to have_css("table > thead > tr", text: "Date")
    expect(page).to have_css("table > thead > tr", text: "Status")
    expect(page).to have_css("table > thead > tr", text: "Price")
    expect(page).to have_content(available.available_date)
    expect(page).to have_content(available.status)
    expect(page).to have_content(available.price)
  end

  scenario "host edits pricing for a date" do
    page.find('tr', text: location.name).click_link('Edit')
    click_link "Update Availability"
    save_new_available_date
    expect {
      page.find('tr', text: available.available_date).click_link('Edit')
      fill_in "available_date_price", with: "21.95"
      click_button "Save"
    }.to change(AvailableDate, :count).by(0)
    expect(page).to have_content('Available date updated')
    expect(page).to have_content("21.95")
  end

  scenario "host deletes an available date" do
    page.find('tr', text: location.name).click_link('Edit')
    click_link "Update Availability"
    save_new_available_date
    expect {
      page.find('tr', text: available.available_date).click_link('Delete')
    }.to change(AvailableDate, :count).by(-1)
    expect(page).to have_content('Available date deleted.')
    expect(page).to_not have_content(available.available_date)
  end


# utility methods

  def save_new_available_date
    click_link "New Availability"
    fill_in "start_date", with: Date.today
    fill_in "end_date", with: Date.today
    fill_in "price", with: available.price
    click_button "Save"
  end

  def save_new_available_date_range
    click_link "New Availability"
    fill_in "start_date", with: Date.today
    fill_in "end_date", with: Date.today + 1.week
    fill_in "price", with: available.price
    click_button "Save"
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