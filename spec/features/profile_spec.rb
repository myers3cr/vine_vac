require 'rails_helper'

feature 'member must have a profile' do
  let(:member) { FactoryGirl.create(:member) }
  let(:profile) { FactoryGirl.create(:profile) }

  scenario "filling in the profile form" do
    visit root_path
    sign_in
    click_link "Profile"
    fill_in_profile_fields
    click_button "Save"
    expect(page).to have_content("Profile updated successfully.")
  end

  scenario "add optional profile picture" do
    visit root_path
    sign_in
    click_link "Profile"
    fill_in_profile_fields
    profile_pic_path = "spec/files/profile_pic.png"
    attach_file "profile[profile_pic]", profile_pic_path
    click_button "Save"
    profile = Profile.last
    expect(profile).to have_attributes(profile_pic_file_name: a_value)
  end

  def sign_in
    visit root_path
    click_link "Sign in"
    fill_in_signin_fields
  end

  def fill_in_signin_fields
    fill_in "member[email]", with: member.email
    fill_in "member[password]", with: member.password
    click_button "Sign in"
  end

def fill_in_profile_fields
    fill_in "profile[first_name]", with: profile.first_name
    fill_in "profile[last_name]", with: profile.last_name
    fill_in "profile[address_1]", with: profile.address_1
    fill_in "profile[address_2]", with: profile.address_2
    fill_in "profile[city]", with: profile.city
    fill_in "profile[state]", with: profile.state
    fill_in "profile[postal_code]", with: profile.postal_code
  end

end