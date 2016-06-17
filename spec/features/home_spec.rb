require 'rails_helper'

feature "visiting the homepage" do

  before(:each) do
    visit root_path
  end
  
  scenario "the visitor sees welcome text" do
    expect(page).to have_text("Welcome to Vineyard Vacations")
  end
  scenario "the visitor sees 'join us' button" do
    expect(page).to have_button("Join Us!")
  end
  scenario "the visitor sees 'sign up' link" do
    expect(page).to have_link("Sign up")
  end
  scenario "the visitor sees 'sign in' link" do
    expect(page).to have_link("Sign in")
  end 

end