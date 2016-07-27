require 'rails_helper'

describe Location, type: :model do

  let(:location) { FactoryGirl.build(:location) }

  it "has a valid factory" do
    expect(location).to be_valid
  end

  it "is invalid without a name" do
    location.name = nil
    expect(location).to be_invalid
    expect(location.errors[:name]).to include("can't be blank")
  end
    
  it "is invalid without a description" do
    location.description = nil
    expect(location).to be_invalid
    expect(location.errors[:description]).to include("can't be blank")
  end
  
  it "is invalid without an address_1" do
    location.address_1 = nil
    expect(location).to be_invalid
    expect(location.errors[:address_1]).to include("can't be blank")
  end
  
  it "is invalid without a city" do
    location.city = nil
    expect(location).to be_invalid
    expect(location.errors[:city]).to include("can't be blank")
  end

  it "is invalid without a state" do
    location.state = nil
    expect(location).to be_invalid
    expect(location.errors[:state]).to include("can't be blank")
  end

  it "is invalid without a postal_code" do
    location.postal_code = nil
    expect(location).to be_invalid
    expect(location.errors[:postal_code]).to include("is invalid")
  end

  it "is invalid with a bad postal_code" do
    location.postal_code = "1234"
    expect(location).to be_invalid
    expect(location.errors[:postal_code]).to include("is invalid")
    location.postal_code = "12345-"
    expect(location).to be_invalid
    expect(location.errors[:postal_code]).to include("is invalid")
  end

  it "returns the location's city, state and zip as a single string" do
    expect(location.csz).to eq (location.city + ", " + location.state + " " + location.postal_code)
  end

end