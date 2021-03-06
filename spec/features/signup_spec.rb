require 'rails_helper'

feature "Visitor must be able to sign up" do
  let(:member) { FactoryGirl.build(:member) }

  def fill_in_signup_fields
    fill_in "member[email]", with: member.email
    fill_in "member[password]", with: member.password
    fill_in "member[password_confirmation]", with: member.password
  end

  scenario "visiting the site to sign up" do
    visit root_path
    click_link "I've seen enough. Sign me up!"
    fill_in_signup_fields
    expect {
      click_button "Sign up"
    }.to change(Member, :count).by(1)
    expect(page).to have_content("signed up successfully.")
  end

end