require 'rails_helper'

RSpec.describe Profile, type: :model do

  it "has a valid factory" do
    expect(build(:profile)).to be_valid
  end

  it "is invalid without a first_name" do
    expect(build(:profile, first_name: nil)).to be_invalid
  end
    
  it "is invalid without a last_name" do
    expect(build(:profile, last_name: nil)).to be_invalid
  end
  
  it "is invalid without an address_1" do
    expect(build(:profile, address_1: nil)).to be_invalid
  end
  
  it "is invalid without a city" do
    expect(build(:profile, city: nil)).to be_invalid
  end

  it "is invalid without a state" do
    expect(build(:profile, state: nil)).to be_invalid
  end

  it "is invalid without a postal_code" do
    expect(build(:profile, postal_code: nil)).to be_invalid
  end

end