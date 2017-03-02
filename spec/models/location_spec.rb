require 'rails_helper'

describe Location, type: :model do

  let(:location) { FactoryGirl.build(:location) }

  it "has a valid factory" do
    expect(location).to be_valid
  end

  it "is invalid without a nearest lake" do
    location.nearest_lake = nil
    expect(location).to be_invalid
    expect(location.errors[:nearest_lake]).to include("is not a Finger Lake")
  end

  it "is invalid without a loc_type" do
    location.loc_type = nil
    expect(location).to be_invalid
    expect(location.errors[:loc_type]).to include("is not an appropriate type")
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

  it "is invalid without an appropriate occupancy" do
    location.occupancy = nil
    expect(location).to be_invalid
    expect(location.errors[:occupancy]).to include("must be a whole number greater than zero")
    location.occupancy = -1
    expect(location).to be_invalid
    expect(location.errors[:occupancy]).to include("must be a whole number greater than zero")
  end

  it "is invalid without an address_1" do
    location.address_1 = nil
    expect(location).to be_invalid
    expect(location.errors[:address_1]).to include("can't be blank")
  end

  it "is valid without an address_2" do
    location.address_2 = nil
    expect(location).to be_valid
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

  it "returns the location's name, city, state and zip as a single string" do
    expect(location.name_and_area).to eq (location.name + ' ' + location.csz)
  end

  it "returns the full street address as a single string for geolocation" do
    expect(location.full_street_address).to eq(location.address_1 + ", " + location.city + ", " + location.state + ", " + "US")
  end

  it "adds latitude and longitude when saved" do
    expect(location.latitude).to be_blank
    expect(location.longitude).to be_blank
    location.save
    location.reload
    expect(location.latitude).to_not be_blank
    expect(location.longitude).to_not be_blank
  end

end
