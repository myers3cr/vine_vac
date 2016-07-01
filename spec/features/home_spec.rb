require 'rails_helper'

feature "There must be a homepage" do

  before(:each) do
    visit root_path
  end
  
  scenario "the visitor sees welcome text" do
    expect(page).to have_text("Welcome to Vineyard Vacations")
  end
  scenario "the visitor sees 'join us' button" do
    expect(page).to have_link("I've seen enough. Sign me up!")
  end
  scenario "the visitor sees the 'about' link" do
    expect(page).to have_link('About')
  end
  scenario "the 'about' link goes to the 'about' page" do
    click_link "About"
    expect(page).to have_text("About")
  end
  scenario "the visitor sees the 'contact' link" do
    expect(page).to have_link('Contact')
  end
  scenario "the 'contact' link goes to the 'contact' page" do
    click_link "Contact"
    expect(page).to have_text("Contact")
  end
  scenario "the 'contact' page has a contact form" do
    click_link "Contact"
    expect(page).to have_css('form')
  end
  scenario "the visitor sees 'sign up' link" do
    expect(page).to have_link("Sign up")
  end
  scenario "the visitor sees 'sign in' link" do
    expect(page).to have_link("Sign in")
  end 

end