require 'rails_helper'

describe Member, type: :model do

  let(:member) { FactoryGirl.build(:member) }

  it "has a valid factory" do
    expect(member).to be_valid
  end

  it "is invalid without email" do
    member.email = nil
    expect(member).to be_invalid
    expect(member.errors[:email]).to include "can't be blank"
  end
    
  it "is invalid without a password" do
    member.password = nil
    expect(member).to be_invalid
    expect(member.errors[:password]).to include "can't be blank"
  end
  
end
