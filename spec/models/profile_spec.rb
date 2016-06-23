require 'rails_helper'

RSpec.describe Profile, type: :model do

  let(:profile) { FactoryGirl.build(:profile) }

  it "has a valid factory" do
    expect(profile).to be_valid
  end

  it "is invalid without a first_name" do
    profile.first_name = nil
    expect(profile).to be_invalid
    expect(profile.errors[:first_name]).to include("can't be blank")
  end
    
  it "is invalid without a last_name" do
    profile.last_name = nil
    expect(profile).to be_invalid
    expect(profile.errors[:last_name]).to include("can't be blank")
  end
  
  it "is invalid without an address_1" do
    profile.address_1 = nil
    expect(profile).to be_invalid
    expect(profile.errors[:address_1]).to include("can't be blank")
  end
  
  it "is invalid without a city" do
    profile.city = nil
    expect(profile).to be_invalid
    expect(profile.errors[:city]).to include("can't be blank")
  end

  it "is invalid without a state" do
    profile.state = nil
    expect(profile).to be_invalid
    expect(profile.errors[:state]).to include("can't be blank")
  end

  it "is invalid without a postal_code" do
    profile.postal_code = nil
    expect(profile).to be_invalid
    expect(profile.errors[:postal_code]).to include("can't be blank")
  end

  it "returns the member's full name" do
    expect(profile.full_name).to eq (profile.first_name + " " + profile.last_name)
  end

  it "returns the member's city, state and zip as a single string" do
    expect(profile.csz).to eq (profile.city + "," + profile.state + " " + profile.postal_code)
  end

end