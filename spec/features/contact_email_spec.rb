require 'rails_helper'

feature "Visitors and Members must be able to send a contact email" do
  let(:contact) { FactoryGirl.build(:contact) }
  let(:member) { FactoryGirl.create(:member) }

  scenario "visitor sends a contact email" do
    visit root_path
    click_link "Contact"
    fill_in_contact_fields
    click_button "Send"
    expect(page).to have_content("Thank you for your message.")
    check_email_fields
  end

  scenario "member sends a contact email" do
    visit root_path
    click_link "Sign in"
    fill_in_signin_fields
    click_button "Sign in"
    expect(page).to have_content("Signed in successfully.")
    click_link "Contact"
    fill_in_contact_fields
    click_button "Send"
    expect(page).to have_content("Thank you for your message.")
    check_email_fields
  end

  def check_email_fields
    open_email("myers3.cr@gmail.com")
    expect(current_email.to).to eq ["myers3.cr@gmail.com"]
    expect(current_email.from).to eq ["myers3.cr@gmail.com"]
    expect(current_email).to have_content(contact.name)
    expect(current_email).to have_content(contact.email)
    expect(current_email).to have_content(contact.message)
  end


  def fill_in_signin_fields
    fill_in "member[email]", with: member.email
    fill_in "member[password]", with: member.password
  end

  def fill_in_contact_fields
    fill_in "contact[name]", with: contact.name
    fill_in "contact[email]", with: contact.email
    fill_in "contact[message]", with: contact.message
  end

end