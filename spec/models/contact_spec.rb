require 'rails_helper'

describe Contact, type: :model do

  let(:contact) { FactoryGirl.build(:contact) }

  it "has a valid factory" do
    expect(contact).to be_valid
  end

  it "is invalid without a name" do
    contact.name = nil
    expect(contact).to be_invalid
    expect(contact.errors[:name]).to include("can't be blank")
  end
  
  it "is invalid without email" do
    contact.email = nil
    expect(contact).to be_invalid
    expect(contact.errors[:email]).to include "can't be blank"
  end
    
  it "is invalid without a message" do
    contact.message = nil
    expect(contact).to be_invalid
    expect(contact.errors[:message]).to include "can't be blank"
  end


end